-- source: https://asciiart.cc/view/11079
local HEADER = {
"", "", "", "", "", "", "", "", "", "",
[[                  .      █▀▄▀█ ▄▀█ █▀▀ █░█      .                  ]],
[[                 //      █░▀░█ █▀█ █▄▄ █▀█      \\                 ]],
[[                //                               \\                ]],
[[               //              1.0.0              \\               ]],
[[              //                _._                \\              ]],
[[           .---.              .//|\\.              .---.           ]],
[[ ________ / .-. \_________..-~ _.-._ ~-..________ / .-. \_________ ]],
[[          \ ._. /    H-     '--.___.--'     -H    \ ._. /          ]],
[[           •---•     H          [H]          H     •---•           ]],
[[                    _H_         _H_         _H_                    ]],
[[                    UUU         UUU         UUU                    ]],
"", "", "", "", "", "", "", "",
}
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = HEADER,
        headr_opts = { hl = "DashboardHeader", },
        center = {
          { icon = "  ", desc = "New File", action = "enew", key = "n" },
          { icon = "  ", desc = "Find File", action = "Telescope find_files", key = "p" },
          { icon = "  ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
          { icon = "󰒲  ", desc = "Update", action = "Update", key = "u" },
          { icon = "  ", desc = "Quit", action = "qa", key = "q" },
        },
        footer = {
          "",
          "",
          "",
          "https://github.com/S-Spektrum-M/mach-nvim"
        },
      },
    })
  end,
}

