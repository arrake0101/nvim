local breakpoint_actions = require("plugins.dap.breakpoint_actions")

local M = {}

local state = {
  active = false,
  bufnr = nil,
  saved_maps = {},
}

local group_name = "dap_debug_mode"

local mode_maps = {
  {
    lhs = "c",
    desc = "Debug Continue",
    rhs = function()
      require("dap").continue()
    end,
  },
  {
    lhs = "r",
    desc = "Debug Step Over",
    rhs = function()
      require("dap").step_over()
    end,
  },
  {
    lhs = "a",
    desc = "Debug Step Into",
    rhs = function()
      require("dap").step_into()
    end,
  },
  {
    lhs = "t",
    desc = "Debug Step Out",
    rhs = function()
      require("dap").step_out()
    end,
  },
  {
    lhs = "b",
    desc = "Debug Breakpoint",
    rhs = function()
      breakpoint_actions.api().toggle_breakpoint()
    end,
  },
  {
    lhs = "B",
    desc = "Debug Conditional Breakpoint",
    rhs = function()
      breakpoint_actions.api().set_conditional_breakpoint()
    end,
  },
  {
    lhs = "m",
    desc = "Debug Log Point",
    rhs = function()
      breakpoint_actions.api().set_log_point()
    end,
  },
  {
    lhs = "p",
    desc = "Debug Breakpoints Picker",
    rhs = function()
      breakpoint_actions.open_picker()
    end,
  },
  {
    lhs = "u",
    desc = "Debug UI",
    rhs = function()
      require("dapui").toggle({})
    end,
  },
  {
    lhs = "x",
    desc = "Debug Terminate",
    rhs = function()
      require("dap").terminate()
    end,
  },
}

local function is_source_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  local buftype = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype

  return buftype == "" and filetype ~= "dap-repl" and not filetype:match("^dapui_")
end

local function session_running()
  return require("dap").session() ~= nil
end

local function resolve_target_bufnr(opts)
  opts = opts or {}

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  if not is_source_buffer(bufnr) then
    return nil
  end

  return bufnr
end

local function capture_buffer_map(bufnr, lhs)
  local map = vim.api.nvim_buf_call(bufnr, function()
    return vim.fn.maparg(lhs, "n", false, true)
  end)

  if type(map) ~= "table" or vim.tbl_isempty(map) or map.buffer ~= 1 then
    return nil
  end

  return map
end

local function restore_buffer_map(bufnr, map)
  if not map then
    return
  end

  local rhs = map.callback or map.rhs
  if rhs == nil or rhs == "" then
    return
  end

  vim.keymap.set("n", map.lhs, rhs, {
    buffer = bufnr,
    desc = map.desc,
    expr = map.expr == 1,
    nowait = map.nowait == 1,
    remap = map.noremap == 0,
    replace_keycodes = map.replace_keycodes == 1,
    script = map.script == 1,
    silent = map.silent == 1,
    unique = map.unique == 1,
  })
end

local function hint_lines()
  return table.concat({
    "Debug Mode",
    "c continue",
    "r step over",
    "a step into",
    "t step out",
    "b breakpoint",
    "B conditional breakpoint",
    "m log point",
    "p breakpoints picker",
    "u toggle ui",
    "x terminate",
    "q / <Esc> exit",
  }, "\n")
end

function M.exit(opts)
  opts = opts or {}

  if not state.active or not state.bufnr then
    return
  end

  local bufnr = state.bufnr
  pcall(vim.api.nvim_del_augroup_by_name, group_name)

  if vim.api.nvim_buf_is_valid(bufnr) then
    for _, map in ipairs(mode_maps) do
      pcall(vim.keymap.del, "n", map.lhs, { buffer = bufnr })
    end
    pcall(vim.keymap.del, "n", "q", { buffer = bufnr })
    pcall(vim.keymap.del, "n", "<Esc>", { buffer = bufnr })

    for _, map in pairs(state.saved_maps) do
      restore_buffer_map(bufnr, map)
    end

    vim.b[bufnr].dap_debug_mode = nil
  end

  state.active = false
  state.bufnr = nil
  state.saved_maps = {}

  if opts.notify then
    vim.notify("Debug mode off", vim.log.levels.INFO, { title = "DAP" })
  end
end

function M.enter(opts)
  opts = opts or {}

  if not session_running() then
    vim.notify("Start a debug session before entering debug mode.", vim.log.levels.WARN, { title = "DAP" })
    return
  end

  local bufnr = resolve_target_bufnr(opts)
  if not bufnr then
    if not opts.auto then
      vim.notify("Enter debug mode from a source buffer.", vim.log.levels.WARN, { title = "DAP" })
    end
    return
  end

  if state.active and state.bufnr == bufnr then
    if opts.auto then
      return
    end
    M.exit({ notify = true })
    return
  end

  if state.active then
    M.exit()
  end

  state.active = true
  state.bufnr = bufnr
  state.saved_maps = {}

  for _, map in ipairs(mode_maps) do
    state.saved_maps[map.lhs] = capture_buffer_map(bufnr, map.lhs)
    vim.keymap.set("n", map.lhs, map.rhs, {
      buffer = bufnr,
      desc = map.desc,
      nowait = true,
      silent = true,
    })
  end

  vim.keymap.set("n", "q", function()
    M.exit({ notify = true })
  end, {
    buffer = bufnr,
    desc = "Exit Debug Mode",
    nowait = true,
    silent = true,
  })

  vim.keymap.set("n", "<Esc>", function()
    M.exit({ notify = true })
  end, {
    buffer = bufnr,
    desc = "Exit Debug Mode",
    nowait = true,
    silent = true,
  })

  vim.b[bufnr].dap_debug_mode = true

  vim.api.nvim_create_augroup(group_name, { clear = true })
  vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden", "BufWipeout" }, {
    buffer = bufnr,
    group = group_name,
    callback = function()
      M.exit()
    end,
  })

  vim.notify(hint_lines(), vim.log.levels.INFO, { title = "DAP" })
end

function M.setup(dap)
  -- Record the source buffer when a debug configuration is started.
  -- We reuse it on `event_initialized` so auto-enter still targets the code buffer
  -- even if dap-ui opens extra windows during session startup.
  dap.listeners.on_config["dap_debug_mode"] = function(config)
    config = vim.deepcopy(config)
    config.__dap_debug_mode_bufnr = resolve_target_bufnr({ bufnr = vim.api.nvim_get_current_buf() })
    return config
  end

  dap.listeners.after.event_initialized["dap_debug_mode"] = function(session)
    vim.schedule(function()
      local bufnr = session
        and session.config
        and session.config.__dap_debug_mode_bufnr
        or resolve_target_bufnr({ bufnr = vim.api.nvim_get_current_buf() })

      if bufnr then
        M.enter({ auto = true, bufnr = bufnr })
      end
    end)
  end

  local function exit_if_active()
    vim.schedule(function()
      if state.active and require("dap").session() == nil then
        M.exit()
      end
    end)
  end

  dap.listeners.before.event_terminated["dap_debug_mode"] = exit_if_active
  dap.listeners.before.event_exited["dap_debug_mode"] = exit_if_active
  dap.listeners.before.disconnect["dap_debug_mode"] = exit_if_active
end

return M
