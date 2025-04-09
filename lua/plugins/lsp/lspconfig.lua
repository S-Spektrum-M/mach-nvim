--[[ return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = 'mason.nvim',
    config = function()
        local langServers = {
            "bashls",        -- bashls
            -- "clangd",        -- C++
            "cmake",         --CMake
            "denols",        -- Javascript
            "gopls",         -- Go
            "jsonls",        -- JSON
            -- "ltex",                 -- Latex/Markdown; mad annoying sometimes
            "lua_ls",        -- Lua
            "pylsp",         -- python
            "rust_analyzer", -- Rust
            "taplo",         -- TOML
            "texlab",        -- Latex
            "yamlls",        -- YAML
            "zls",           -- Zig
        }

        local lsp = require("lspconfig")
        for _, v in pairs(langServers) do
            lsp[v].setup({})
        end
        lsp["clangd"].setup({
            cmd = { "/usr/bin/clangd", "--clang-tidy" }
        })
    end
} ]]

return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = 'mason.nvim',
  config = function()
    local lspconfig = require("lspconfig")

    local servers = {
      bashls = {},
      cmake = {},
      denols = {},
      gopls = {},
      jsonls = {},
      lua_ls = {},
      pylsp = {},
      rust_analyzer = {},
      taplo = {},
      texlab = {},
      yamlls = {},
      zls = {},
      -- ltex = {}, -- Uncomment if needed
    }

    -- Lazy setup per filetype
    local ft_to_server = {
      sh = "bashls",
      c = "clangd",
      cpp = "clangd",
      cmake = "cmake",
      javascript = "denols",
      typescript = "denols",
      go = "gopls",
      json = "jsonls",
      lua = "lua_ls",
      python = "pylsp",
      rust = "rust_analyzer",
      toml = "taplo",
      tex = "texlab",
      yaml = "yamlls",
      zig = "zls",
      markdown = "ltex",
    }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local server = ft_to_server[args.match]
        if not server or lspconfig[server].manager then return end

        if server == "clangd" then
          lspconfig.clangd.setup({
            cmd = { "/usr/bin/clangd", "--clang-tidy" }
          })
        else
          lspconfig[server].setup(servers[server] or {})
        end
      end
    })
  end
}
