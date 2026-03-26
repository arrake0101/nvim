local helpers = require("plugins.dap.helpers")

local M = {
  mason_packages = {
    "debugpy",
  },
}

local function adapter_entry()
  return vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter"
end

local function assert_exists(path, label, hint)
  if (vim.uv or vim.loop).fs_stat(path) then
    return path
  end

  local message = ("%s not found at %s"):format(label, path)
  if hint then
    message = message .. "\n" .. hint
  end

  error(message)
end

local function project_python(cwd)
  local candidates = {
    cwd .. "/.venv/bin/python",
    cwd .. "/venv/bin/python",
    vim.fn.exepath("python3"),
    vim.fn.exepath("python"),
  }

  -- Prefer the project's virtualenv first so imports and package versions
  -- match the code you are actually debugging.
  for _, candidate in ipairs(candidates) do
    if candidate and candidate ~= "" and (vim.uv or vim.loop).fs_stat(candidate) then
      return candidate
    end
  end

  error("No Python interpreter found. Install python3 or create a project virtualenv.")
end

function M.setup(dap)
  -- This file only configures the `debugpy` adapter for Python.
  -- Enabling it here also tells Mason to install `debugpy`.
  dap.adapters.debugpy = function(callback, config)
    if config.request == "attach" then
      local connect = config.connect or config

      callback({
        type = "server",
        host = connect.host or "127.0.0.1",
        port = assert(connect.port, "`connect.port` is required for debugpy attach"),
        options = {
          source_filetype = "python",
        },
      })
      return
    end

    callback({
      type = "executable",
      command = assert_exists(
        adapter_entry(),
        "debugpy-adapter",
        "Install it manually with :MasonInstall debugpy"
      ),
      options = {
        source_filetype = "python",
      },
    })
  end

  local python_configs = dap.configurations.python or {}

  helpers.upsert_config(python_configs, {
    type = "debugpy",
    request = "launch",
    name = "Python file",
    cwd = function()
      return vim.fn.getcwd()
    end,
    program = function()
      return helpers.current_file("Save the current Python file before starting the debugger.")
    end,
    python = function()
      return project_python(vim.fn.getcwd())
    end,
    justMyCode = true,
  })

  helpers.upsert_config(python_configs, {
    type = "debugpy",
    request = "attach",
    name = "Attach to debugpy (:5678)",
    connect = {
      host = "127.0.0.1",
      port = 5678,
    },
  })

  dap.configurations.python = python_configs
end

return M
