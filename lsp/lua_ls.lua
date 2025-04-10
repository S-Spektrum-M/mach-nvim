local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

-- config from: u/Reid720 on r/neovim
local default_config = {
  cmd = { exe_name("lua-language-server") },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  telemetry = { enabled = false },
  formatters = {
    ignoreComments = false,
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      signatureHelp = { enabled = true },
    },
  },
}


return default_config
