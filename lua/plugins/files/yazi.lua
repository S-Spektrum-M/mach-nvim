return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    -- check the installation instructions at
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim"
  },
  keys = {
    {
      "<leader>cw",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current working directory",
    },
    {
      "<c-t>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
}
