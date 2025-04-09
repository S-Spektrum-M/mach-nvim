-- source: https://asciiart.cc/view/11079
local HEADER_CONTENT = {
  [[                  .      █▀▄▀█ ▄▀█ █▀▀ █░█      .                  ]],
  [[                 //      █░▀░█ █▀█ █▄▄ █▀█      \\                 ]],
  [[                //                               \\                ]],
  [[               //                                 \\               ]],
  [[              //                _._                \\              ]],
  [[           .---.              .//|\\.              .---.           ]],
  [[ ________ / .-. \_________..-~ _.-._ ~-..________ / .-. \_________ ]],
  [[          \ ._. /    H-     '--.___.--'     -H    \ ._. /          ]],
  [[           •---•     H          [H]          H     •---•           ]],
  [[                    _H_         _H_         _H_                    ]],
  [[                    UUU         UUU         UUU                    ]],
}

local CENTER_ENTRIES = {
  { icon = "  ", desc = "New File", action = "enew", key = "n" },
  { icon = "  ", desc = "Find File", action = "Telescope find_files", key = "p" },
  { icon = "  ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
  { icon = "󰒲  ", desc = "Update", action = "Update", key = "u" },
  { icon = "  ", desc = "Quit", action = "qa", key = "q" },
}

local nvim_ver = vim.version()
local nvim_version_str = string.format("neovim v%d.%d.%d", nvim_ver.major, nvim_ver.minor, nvim_ver.patch)
local footer_left_padding = string.rep(" ", #nvim_version_str - 11)

local FOOTER_CONTENT = { footer_left_padding .. "run :h mach   mach-nvim v1.1.0   " .. nvim_version_str }

local function padded_layout()
  local win_height = vim.api.nvim_win_get_height(0)
  local header_lines = #HEADER_CONTENT
  local center_lines = #CENTER_ENTRIES
  local footer_lines = #FOOTER_CONTENT

  local used_lines = header_lines + center_lines + footer_lines
  local remaining_lines = win_height - used_lines

  local top_pad = math.floor(remaining_lines / 3)
  local between_pad = math.floor(remaining_lines / 6)
  local bottom_pad = remaining_lines - top_pad - between_pad - 5 -- 5 is the number of dashboard options

  local header = vim.list_extend(vim.list_extend(vim.fn["repeat"]({ "" }, top_pad), HEADER_CONTENT), vim.fn["repeat"]({ "" }, between_pad))
  local footer = vim.list_extend(vim.fn["repeat"]({ "" }, bottom_pad), FOOTER_CONTENT)

  return header, footer
end

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local header, footer = padded_layout()

    require("dashboard").setup({
      theme = "doom",
      config = {
        header = header,
        header_opts = { hl = "DashboardHeader" },
        center = CENTER_ENTRIES,
        footer = footer,
      },
    })
  end,
}
