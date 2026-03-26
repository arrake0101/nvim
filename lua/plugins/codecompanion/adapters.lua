local settings = require("plugins.codecompanion.settings")
local storage = require("plugins.codecompanion.storage")

local M = {}

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

function M.codex_command()
  local cached = cached_codex_acp()
  if cached and vim.fn.executable(cached) == 1 then
    return cached
  end

  if vim.fn.executable("codex-acp") == 1 then
    return "codex-acp"
  end

  return nil
end

function M.codex_command_args()
  local command = M.codex_command()
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

function M.interaction_adapter(adapter)
  if adapter == "codex" then
    return {
      name = "codex",
      model = settings.codex_model,
    }
  end

  return adapter
end

function M.resolve_history_adapter()
  local ok, codecompanion = pcall(require, "codecompanion")
  if ok then
    local chat = codecompanion.last_chat()
    if chat and chat.adapter and chat.adapter.type == "acp" then
      return chat.adapter
    end
  end

  local adapter_registry = require("codecompanion.adapters")
  local adapter = adapter_registry.resolve(M.interaction_adapter(settings.default_adapter))
  if adapter and adapter.type == "acp" then
    return adapter
  end

  return adapter_registry.resolve(M.interaction_adapter("codex"))
end

function M.codex_env()
  return {
    HOME = vim.env.HOME,
    PATH = vim.env.PATH,
    CODEX_HOME = storage.codex_home(),
    OPENAI_API_KEY = vim.env.OPENAI_API_KEY,
    CODEX_API_KEY = vim.env.CODEX_API_KEY,
  }
end

return M
