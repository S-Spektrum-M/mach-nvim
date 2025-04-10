#   Mach - Neovim Configuration

A modern Neovim configuration focused on a productive development environment with minimal overhead.

##  Installation

```bash
wget https://raw.githubusercontent.com/S-Spektrum-M/mach-nvim/main/install.sh
chmod +x install.sh
# use the following for automated install
./install.sh -nupig -m SOURCE
# use the following for Interactive install
./install.sh
````

## Features

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins, and includes:

### Core Functionality

- **LSP:** Integrated support via `nvim-lspconfig` and `mason.nvim` for easy server installation.
- **Completion:** Fast autocompletion with `blink.cmp` and snippets via `friendly-snippets`.
- **Fuzzy Finding:** Advanced searching with `telescope.nvim`.
- **File Explorer:** Tree-style file view with `nvim-tree.lua`.
- **Git Integration:** Includes `vim-fugitive`, `gitsigns.nvim`, and `diffview.nvim`.
- **Syntax Highlighting:** Via `nvim-treesitter`.

### UI Enhancements

- **Statusline:** `lualine.nvim`.
- **Icons:** `nvim-web-devicons`.
- **Theme:** `onedarkpro.nvim`.
- **Keymap Help:** `which-key.nvim`.
- **Diagnostics Display:** `trouble.nvim`.
- **Winbar:** `barbecue.nvim`.
- **Misc UI:** `snacks.nvim`.

### Editing Tools

- Commenting: `Comment.nvim`
- Motions: `leap.nvim`
- Auto-save: `vim-auto-save`
- TODO Highlighting: `todo-comments.nvim`
- Marks: `vim-signature`
- Floating terminal: `vim-floaterm`
- Tmux navigation: `vim-tmux-navigator`

### Language Specific

- LaTeX: `vimtex`

### AI Tools

- `avante.nvim` with OpenAI integration

## Prerequisites

- **Neovim:** Version 0.11+ (older versions will not work)
- **Git:** For cloning and plugin management
- **Nerd Font:** For icon display
- *(Optional)* **Build Tools:** `make`, C compiler (for Treesitter and LSP)
- *(Optional)* **OpenAI Key:** For `avante.nvim`

## Keymaps

### General

- `<leader>`: Open `which-key` menu
- `<C-p>`: Find files (Telescope)
- `<C-r>`: Live grep (Telescope)
- `<C-b>` / `<C-n>`: Open buffers (Telescope)
- `<C-t>`: Toggle file tree (NvimTree)
- `<leader>t`: Toggle Trouble
- `<leader>st`: Toggle Symbols Outline
- `<F7>` / `<F12>`: Floaterm control
- `<leader>]`: Trigger Gen (Ollama)
- `<leader>m`: Render file
- `<leader><F10>`: Run file

### LSP

- `gd`: Go to definition
- `gD`: Go to declaration
- `K`: Hover doc
- `gi`: Go to implementation
- `gr`: Find references
- `grn`: Rename
- `<leader><F2>`: Format

### Git

- `ghn` / `ghp`: Next/Previous hunk
- `ghP`: Preview hunk
- `ghc` / `ghC`: Stage/Unstage hunk
- `<leader>gc`: Commit file
- `<leader>gp` / `gP`: Push/Pull
- `<leader>gL`: Git log
- `<leader>gS`: Git status
- `<leader>do` / `dc`: Diffview open/close

## Customization

Edit `lua/plugins/custom.lua`:

```lua
return {
-- Example:
-- {
--   'user/plugin',
--   config = function()
--     -- Setup code here
--   end,
-- },

-- vim.opt.relativenumber = false
}
```

## Acknowledgements

### Plugins

| Plugin | Description |
|---|---|
|   [lazy.nvim](https://github.com/folke/lazy.nvim) |   Startup plugin manager |
|   [avante.nvim](https://github.com/yetone/avante.nvim) |   AI integration |
|   [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) |   Winbar component |
|   [blink.cmp](https://github.com/Saghen/blink.cmp) |   Completion engine |
|   [Comment.nvim](https://github.com/numToStr/Comment.nvim) |   Commenting support |
|   [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) |   Icons for UI |
|   [diffview.nvim](https://github.com/sindrets/diffview.nvim) |   Git diffs UI |
|   [vim-floaterm](https://github.com/voldikss/vim-floaterm) |   Floating terminal |
|   [vim-fugitive](https://github.com/tpope/vim-fugitive) |   Git commands in Neovim |
|   [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) |   Git signs & blame |
|   [leap.nvim](https://github.com/ggandor/leap.nvim) |   Motion plugin |
|   [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |   Statusline |
|   [mason.nvim](https://github.com/williamboman/mason.nvim) |   LSP installer |
|   [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim) |   Symbol tree |
|   [vim-auto-save](https://github.com/907th/vim-auto-save) |   Auto-save buffer |
|   [vim-signature](https://github.com/kshenoy/vim-signature) |   Mark indicators |
|   [snacks.nvim](https://github.com/folke/snacks.nvim) |   UI/UX enhancements |
|   [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) |   Finder engine |
|   [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) |   Tmux integration |
|   [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) |   TODO highlighting |
|   [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) |   File tree view |
|   [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |   Syntax highlighting |
|   [trouble.nvim](https://github.com/folke/trouble.nvim) |   Diagnostics panel |
|   [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) |   Rainbow parens |
|   [vimtex](https://github.com/lervag/vimtex) |   LaTeX support |
|   [which-key.nvim](https://github.com/folke/which-key.nvim) |   Keymap hint UI |
|   [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim) |   Colorscheme |

## Performance

![assets/tf\_edit.png](about:sanitized)
- startup time when editing [this file](https://www.google.com/search?q=https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/model.cc)
