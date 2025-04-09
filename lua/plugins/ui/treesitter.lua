return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,      -- async parser install
        auto_install = false,      -- avoid delay on first open
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        disable = { "gitcommit" },
      })
    end, 20) -- delay to avoid blocking BufReadPost
  end,
}

