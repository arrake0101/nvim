local settings = {
  -- Flip this to false when you want Lazy.nvim to skip loading CodeCompanion entirely.
  enabled = true,
  default_adapter = "codex",
  codex_model = "gpt-5.4-mini",
  -- Supported by GPT-5.4 family in Codex: low | medium | high | xhigh
  codex_reasoning_effort = "xhigh",
  codex_auth_method = "chatgpt",
}

local function codex_home()
  if vim.env.CODEX_HOME and vim.env.CODEX_HOME ~= "" then
    return vim.env.CODEX_HOME
  end
  return (vim.env.HOME or "") .. "/.codex"
end

local function cached_codex_acp()
  local home = vim.env.HOME or ""
  local patterns = {
    home
      .. "/.npm/_npx/*/node_modules/@zed-industries/codex-acp/node_modules/@zed-industries/codex-acp-*/bin/codex-acp",
    home .. "/.npm/_npx/*/node_modules/@zed-industries/codex-acp-*/bin/codex-acp",
  }

  for _, pattern in ipairs(patterns) do
    local matches = vim.fn.glob(pattern, false, true)
    if #matches > 0 then
      return matches[1]
    end
  end
end

local function codex_command()
  local cached = cached_codex_acp()
  if cached and vim.fn.executable(cached) == 1 then
    return cached
  end
  if vim.fn.executable("codex-acp") == 1 then
    return "codex-acp"
  end
  return nil
end

local function codex_command_args()
  local command = codex_command()
  if not command then
    return nil
  end

  local args = { command }

  if settings.codex_reasoning_effort and settings.codex_reasoning_effort ~= "" then
    table.insert(args, "-c")
    table.insert(args, string.format('model_reasoning_effort="%s"', settings.codex_reasoning_effort))
  end

  return args
end

local function escape_prompt(prompt)
  return vim.fn.escape((prompt or ""):gsub("[%r\n]+", " "), [[\|]])
end

local function interaction_adapter(adapter)
  if adapter == "codex" then
    return {
      name = "codex",
      model = settings.codex_model,
    }
  end

  return adapter
end

local function resolve_history_adapter()
  local ok, codecompanion = pcall(require, "codecompanion")
  if ok then
    local chat = codecompanion.last_chat()
    if chat and chat.adapter and chat.adapter.type == "acp" then
      return chat.adapter
    end
  end

  local adapters = require("codecompanion.adapters")
  local adapter = adapters.resolve(interaction_adapter(settings.default_adapter))
  if adapter and adapter.type == "acp" then
    return adapter
  end

  return adapters.resolve(interaction_adapter("codex"))
end

local function format_history_label(session)
  local utils = require("codecompanion.utils")
  local parts = {}
  local title = session.title and session.title ~= "" and session.title or session.sessionId

  if session.updatedAt then
    local ts = utils.parse_iso8601(session.updatedAt)
    if ts then
      table.insert(parts, "(" .. utils.make_relative(ts) .. ")")
    end
  end

  table.insert(parts, title)

  return table.concat(parts, " ")
end

local function format_history_preview(session)
  local title = session.title and session.title ~= "" and session.title or "Untitled Session"
  local lines = {
    "# " .. title,
    "",
    "- Session ID: `" .. session.sessionId .. "`",
  }

  if session.updatedAt then
    table.insert(lines, "- Updated At: `" .. session.updatedAt .. "`")
  end

  if session.cwd and session.cwd ~= "" then
    table.insert(lines, "- Working Dir: `" .. session.cwd .. "`")
  end

  return table.concat(lines, "\n")
end

local function open_history_picker()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("CodeCompanion history picker requires snacks.nvim", vim.log.levels.ERROR)
    return
  end

  local utils = require("codecompanion.utils")
  local adapter = resolve_history_adapter()
  if not adapter or adapter.type ~= "acp" then
    utils.notify("History picker requires an ACP adapter such as Codex", vim.log.levels.WARN)
    return
  end

  local connection = require("codecompanion.acp").new({ adapter = adapter })
  if not connection:connect_and_authenticate() then
    utils.notify("Failed to connect to the ACP adapter", vim.log.levels.ERROR)
    return
  end

  if not connection:can_list_sessions() or not connection:can_load_session() then
    connection:disconnect()
    utils.notify("This ACP adapter does not support restoring session history", vim.log.levels.WARN)
    return
  end

  local sessions = connection:session_list({ max_sessions = 500 })
  if #sessions == 0 then
    connection:disconnect()
    utils.notify("No previous AI sessions found", vim.log.levels.INFO)
    return
  end

  local selected = false
  local items = vim.tbl_map(function(session)
    return {
      text = format_history_label(session),
      item = session,
      preview = {
        text = format_history_preview(session),
        ft = "markdown",
      },
    }
  end, sessions)

  Snacks.picker({
    items = items,
    title = "CodeCompanion History",
    preview = "preview",
    confirm = function(picker, item)
      if not item or not item.item then
        return
      end

      selected = true
      picker:close()

      local session = item.item
      local title = session.title and session.title ~= "" and session.title or session.sessionId
      local Chat = require("codecompanion.interactions.chat")
      local chat = Chat.new({
        hidden = true,
        title = title,
        adapter = adapter,
        buffer_context = {
          bufnr = vim.api.nvim_get_current_buf(),
        },
      })
      chat.acp_connection = connection

      local updates = {}
      local ok_load = connection:load_session(session.sessionId, {
        on_session_update = function(update)
          table.insert(updates, update)
        end,
      })

      if not ok_load then
        connection:disconnect()
        chat:close()
        utils.notify("Failed to load the selected AI session", vim.log.levels.ERROR)
        return
      end

      require("codecompanion.interactions.chat.acp.commands").link_buffer_to_session(chat.bufnr, connection.session_id)
      require("codecompanion.interactions.chat.acp.render").restore_session(chat, updates)

      if title and title ~= "" then
        chat:set_title(title)
      end

      Chat.close_last_chat()
      require("codecompanion").restore(chat.bufnr)
      utils.notify("Resumed session: " .. title)
    end,
    on_close = function()
      if not selected then
        connection:disconnect()
      end
    end,
    format = function(item)
      return { { item.text } }
    end,
  })
end

local function run_visual_prompt(prompt)
  return function()
    vim.cmd("'<,'>CodeCompanion " .. escape_prompt(prompt))
  end
end

local function prompt_inline(opts)
  opts = opts or {}

  vim.ui.input({
    prompt = opts.visual and "CodeCompanion (selection): " or "CodeCompanion: ",
  }, function(input)
    input = vim.trim(input or "")
    if input == "" then
      return
    end

    if opts.include_buffer then
      input = "#{buffer} " .. input
    end

    local command = "CodeCompanion " .. escape_prompt(input)
    if opts.visual then
      command = "'<,'>" .. command
    end
    vim.cmd(command)
  end)
end

local function open_chat_with_adapter(adapter)
  return function()
    local args = { "adapter=" .. adapter }

    if adapter == "codex" then
      local command = codex_command()
      if not command then
        vim.notify(
          "CodeCompanion codex adapter requires a codex-acp executable. Install the Zed codex-acp bridge or refresh your npx cache.",
          vim.log.levels.ERROR
        )
        return
      end
      table.insert(args, "command=default")
    end

    vim.cmd("CodeCompanionChat " .. table.concat(args, " "))
  end
end

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = settings.enabled,
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    init = function()
      vim.env.CODECOMPANION_TOKEN_PATH = vim.fn.expand("~/.config")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "zbirenbaum/copilot.lua",
    },
    opts = function()
      local codex_acp = codex_command_args()

      return {
        adapters = {
          http = {
            opts = {
              show_presets = false,
            },
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {})
            end,
          },
          acp = {
            opts = {
              show_presets = false,
            },
            codex = function()
              return require("codecompanion.adapters").extend("codex", {
                commands = codex_acp and {
                  default = codex_acp,
                } or nil,
                defaults = {
                  auth_method = settings.codex_auth_method,
                  model = settings.codex_model,
                },
                env = {
                  HOME = vim.env.HOME,
                  PATH = vim.env.PATH,
                  CODEX_HOME = codex_home(),
                  OPENAI_API_KEY = vim.env.OPENAI_API_KEY,
                  CODEX_API_KEY = vim.env.CODEX_API_KEY,
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = interaction_adapter(settings.default_adapter),
          },
          inline = {
            adapter = interaction_adapter(settings.default_adapter),
          },
          cmd = {
            adapter = interaction_adapter(settings.default_adapter),
          },
        },
        display = {
          action_palette = {
            provider = "snacks",
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        desc = "CodeCompanion Chat",
      },
      {
        "<leader>aA",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "CodeCompanion Actions",
      },
      {
        "<leader>ap",
        open_chat_with_adapter("copilot"),
        mode = { "n" },
        desc = "CodeCompanion Copilot Chat",
      },
      {
        "<leader>ak",
        open_chat_with_adapter("codex"),
        mode = { "n" },
        desc = "CodeCompanion Codex Chat",
      },
      {
        "<leader>ai",
        function()
          prompt_inline({ include_buffer = true })
        end,
        mode = { "n" },
        desc = "CodeCompanion Inline",
      },
      {
        "<leader>ai",
        function()
          prompt_inline({ visual = true })
        end,
        mode = { "v" },
        desc = "CodeCompanion Inline",
      },
      {
        "<leader>ae",
        run_visual_prompt("/explain"),
        mode = { "v" },
        desc = "Explain Selection",
      },
      {
        "<leader>ax",
        run_visual_prompt("/fix"),
        mode = { "v" },
        desc = "Fix Selection",
      },
      {
        "<leader>at",
        run_visual_prompt("/tests"),
        mode = { "v" },
        desc = "Test Selection",
      },
      {
        "<leader>am",
        "<cmd>CodeCompanionCmd<cr>",
        mode = { "n" },
        desc = "CodeCompanion Command",
      },
      {
        "<leader>ah",
        open_history_picker,
        mode = { "n" },
        desc = "CodeCompanion History",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>a", group = "ai", mode = { "n", "v" } },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
        "yaml",
      })
    end,
  },
}
