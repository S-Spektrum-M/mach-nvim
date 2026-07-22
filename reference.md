# Mach Neovim reference

This document describes the behavior configured in this repository. It is a
reference for this Neovim setup, not a general Neovim manual. Unless stated
otherwise, mappings apply in Normal mode.

`Space` is the leader key. `Ctrl-p` means to hold Control and press `p`.
Commands beginning with `:` are entered at Neovim's command line.

## Requirements and Setup


| Requirement | Purpose |
|---|---|
| Neovim 0.11 or later | This configuration uses Neovim 0.11 native LSP configuration API. |
| Git 2.19 or later | Plugin installation and Git features. |
| `curl` | Required by the documented installer command. |
| `rg` (ripgrep) | Live grep and Neovim's `:grep` command. |
| `fd` | File picker and optional file cache. |
| A Nerd Font | File and interface icons. |

At first start, `lazy.nvim` is cloned into Neovim's data directory and installs
the configured plugins, so network access is required. See [README.md](README.md)
for the installer and its prerequisites. The installer may build Neovim if an
adequate `nvim` is not already on `PATH`.

Optional tools:

| Software | Used for |
|---|---|
| tmux | Pane navigation with `Ctrl-h/j/k/l`. Matching tmux configuration is required to cross from Neovim into tmux panes. |
| Yazi | `Space c w` file browsing. |
| `pandoc`, `pdflatex`, `biber`, Zathura | Document rendering and PDF viewing. |
| `codelldb` | C and C++ debugging; install with `:MasonInstall codelldb`. |
| GitHub Copilot account | Copilot completion, after authentication through `:Copilot`. |

### Updates and Package Management

`:Update` updates:
    - Lazy plugins;
    - installed Tree-sitter parsers;
    - and requests these Mason packages
        - bash-language-server,
        - clangd,
        - deno,
        - gopls,
        - json-lsp,
        - lua-language-server,
        - python-lsp-server,
        - rust-analyzer,
        - taplo,
        - texlab,
        - yaml-language-server,
        - zls,
        - harper-ls.

`:Update` does **not** install `neocmakelsp`. Install it separately if CMake
support is needed: `:MasonInstall neocmakelsp`. `:Mason`, `:MasonInstall`, and
`:MasonUpdate` are available for individual language tools.

## Navigation and Picking

The file picker searches from Neovim's current working directory with
`fd --type f --hidden --follow --exclude .git`: hidden files are included,
symbolic links are followed, and `.git` is excluded.

| Key | Action |
|---|---|
| `Ctrl-p` | Find files. |
| `Ctrl-r` | Live grep with ripgrep. |
| `Ctrl-b` | Pick an open buffer. |
| `Ctrl-a` | Preview and select a colorscheme. May be intercepted by tmux. |
| `Space Ctrl-p` | Pick and run an Ex command. |
| `Space w` / `Space W` | Jump to a visible word after / before the cursor. |
| Backslash / vertical bar | Next / previous buffer. |
| `Space c w` | Open Yazi at the current working directory. |
| `Ctrl-t` | Toggle the most recent Yazi session. |
| `Ctrl-h/j/k/l` | Move left/down/up/right across Neovim and tmux panes. |
| `Ctrl-\` | Return to the previous Neovim/tmux pane. |

The Hop word-jump commands display labels for their selectable targets.

### Cached file list

The cache is an explicit, per-working-directory snapshot produced with
`fd --type file`. It is stored in Neovim's state directory and does not refresh
when files change.

| Key or command | Action |
|---|---|
| `Space i f` or `:InitFdCache` | Create or replace the file cache. |
| `Space f f` or `:ListFdFiles` | Pick a file from the cache. |
| `:ClearFdCache` | Delete the cache. |

Run `Space i f` again after changing the file tree. The normal file picker is
usually preferable.

## Language features and diagnostics

These mappings work when an appropriate language server is attached and
supports the requested operation.

| Key | Action |
|---|---|
| `gd` | Pick a definition. |
| `gD` | Go to a declaration. |
| `gi` | Go to an implementation. |
| `gr` | Pick references. |
| `K` | Show hover documentation. |
| `gR` | Show code actions and refactorings. |
| `Space 2` | Format the current buffer with attached LSP clients. |
| `gK` | Toggle diagnostic presentation. |
| `Space q d` | Put error-severity diagnostics into quickfix. |
| `[d` / `]d` | Previous / next diagnostic. |
| `Space s t` | Search workspace symbols. |

Diagnostics normally use virtual text. `gK` switches to a detailed mode:
warnings and lower severities remain inline while errors are displayed as
virtual lines. Run it again to return to the default.

### LSP jump history

`gd`, `gD`, `gi`, and `gr` record their starting locations in a private LSP
jump stack. It is independent of Neovim's normal jumplist and tag stack.

| Key or command | Action |
|---|---|
| `gb` or `:JumplistBack` | Return to the latest recorded LSP location. |
| `gJ` or `:Jumplist` | Display recorded locations in a picker. |

The stack may contain locations in closed buffers; Neovim reopens a file if it
still exists.

### Quickfix list

| Key | Action |
|---|---|
| `Space q` / `Space q q` | Open / close quickfix. |
| `[q` / `]q` | Previous / next quickfix item. |

## Completion and editing

Completion starts in Insert mode. Sources include language servers, paths,
snippets, words in open buffers, Copilot, and temporary files. The configured
“super-tab” preset makes `Tab` the primary completion and snippet key. The
current completion item is preselected and auto-inserted while navigating.

Other configured editing features:

- Tree-sitter highlighting and indentation apply when a parser is installed.
  Parsers are not installed automatically; `:TSUpdate` updates installed ones.
- Nested delimiters have colour highlighting.
- Markdown buffers use rendered Markdown when the plugin is available.
- TODO-style comments are highlighted after Insert mode has been entered.
- The status line shows diagnostics, Git diff state, LSP symbol path when
  available, progress, and cursor location.

Which-key shows available continuations after the leader key, Control prefixes,
and `z` commands.

## Terminals, running files, and rendering

| Key | Action |
|---|---|
| `Space 3` | Toggle a floating terminal (Normal and Terminal modes). |
| `Space 4` | Run or build according to the current filetype. |
| `Space m` | Render or view the current document. |

`Space 4` opens its command in a terminal and leaves that terminal open.

| Filetype | Configured command or behaviour |
|---|---|
| Python | `python3 {current-file}` |
| JavaScript | `node .` — runs the directory entry point, not necessarily the open file. |
| TypeScript | `tsc {current-file} && node {basename}.js` |
| C | `bear -- clang {current-file} -o {basename} --std=c++23 && ./{basename}` |
| C++ | `bear -- clang++ {current-file} -o {basename} --std=c++23 && ./{basename}` |
| Java | `javac {filename} && java {basename}` |
| Go | `go run {current-file}` |
| Lua | `lua {current-file}` |
| Other | Falls back to document rendering. |

The configured C command passes `--std=c++23` to `clang` even for C files, so
it may fail for C sources. Compile manually or adjust `RunFile` in
`lua/mach/functions.lua` if required. `bear` captures the build for clangd.
These commands pass filenames directly to the shell; avoid the shortcut for
filenames containing shell-special characters.

`Space m` handles the following types:

| Filetype | Action |
|---|---|
| `tex` | Run `pdflatex --shell-escape {basename}`. |
| `plaintex` | Run `biber {basename}`, then `pdflatex --shell-escape {basename}`. |
| Markdown | Run `pandoc {filename} -o {basename}.pdf`, then open it in Zathura. |
| HTML | Run `open {filename}`. |
| Other | Report an unsupported filetype. |

`:TexRender` runs the fast TeX command. `:View` opens a PDF with the same base
name as the current file in Zathura. These workflows require their external
tools and assume a Unix-like system with an `open` command for HTML.

## Git

Git commands operate on the repository containing the current file or working
directory. Push and pull mappings explicitly use the remote named `origin`.

| Key | Action |
|---|---|
| `Space g s` | Pick changed and untracked files. |
| `Space g S` | Open Fugitive's `:Git status` buffer. |
| `Space g a` / `Space g A` | Stage / unstage the current file. |
| `Space g c` | Commit staged changes. |
| `Space g C` | Amend with the current file and edit the commit message. |
| `Space g n` | Amend with the current file without editing the message. |
| `Space g p` | Push to `origin`. |
| `Space g i` | Force-push to `origin` with `--force-with-lease`. |
| `Space g P` | Pull from `origin`. |
| `Space g r` | Start an interactive rebase. |
| `Space g l` | Pick commits from the Git log. |
| `Space g L` | Show a graph-style log in a Fugitive buffer. |
| `Space d t` | Toggle CodeDiff's side-by-side Git explorer. |
| `Space d h` | Show file history in CodeDiff. |
| `Space d c` | Compare the worktree with `HEAD` in CodeDiff. |

`Space g i` can rewrite remote history. Verify the branch and collaborator
impact before using it.

### Hunk actions

| Key | Action |
|---|---|
| `g h n` / `g h p` | Next / previous changed hunk. |
| `g h P` | Preview the current hunk inline. |
| `g h c` / `g h C` | Stage / unstage the current hunk. |
| `g h r` | Reset (discard) the current hunk. |
| `g h b` | Show full-file blame. |

Gitsigns shows line markers and inline blame after the cursor rests on a line
for one second. It does not attach to untracked files. Typical marker colours
are green for additions, yellow for changes, and red for deletions; staged
markers are muted and unstaged markers are bright, subject to the colourscheme.
`g h r` discards working-tree changes.

## Debugging C and C++

Debugging is configured only for C and C++ and uses Mason's `codelldb`. On
launch, Neovim asks for an executable and then for space-separated arguments;
quoted arguments are not parsed specially.

| Key | Action |
|---|---|
| `Space D b` | Toggle a breakpoint. |
| `Space D c` | Start or continue debugging. |
| `Space n` | Step over. |
| `Space i` | Step into. |
| `Space o` | Step out. |
| `Space D r` | Open the debugger REPL. |

The short step mappings are global. Outside an active debug session, they may
report a debugger error instead of performing a normal editing action.

## Language support

Neovim scans the repository's `lsp/` directory at startup and enables every
listed server configuration. Most server executables are supplied by Mason.

| Language or format | Server | Note |
|---|---|---|
| Bash / shell | bash-language-server | Install through Mason. |
| C, C++, Objective-C, CUDA, Protocol Buffers | clangd | A project compilation database improves results. |
| JavaScript / TypeScript | Deno | The runner separately needs Node.js and `tsc` for TypeScript. |
| Go | gopls | The runner also needs the Go toolchain. |
| JSON / JSONC | vscode-json-language-server | Mason package: `json-lsp`. |
| Lua | lua-language-server | The runner also needs a Lua interpreter. |
| CMake | neocmakelsp | Install separately; `:Update` omits it. |
| Python | python-lsp-server (`pylsp`) | The runner also needs `python3`. |
| Rust | rust-analyzer | Install through Mason. |
| TOML | taplo | Install through Mason. |
| TeX | texlab | Rendering also needs the TeX command-line tools. |
| YAML | yaml-language-server | Install through Mason. |
| Zig | zls | Install through Mason. |
| Markdown, text, LaTeX | harper-ls | Prose diagnostics. |

Several servers find their project root from `.git`. clangd also checks
`.clang-format`, `CMakeLists.txt`, and `Makefile`; Python uses `__pycache__`
when present. Project-aware behaviour can therefore differ in standalone files.

## Editor defaults

| Setting | Configured behaviour |
|---|---|
| Leader key | `Space`. |
| Search | Ignore case unless the query contains a capital letter; incremental search is enabled. |
| Indentation | Four-space tabs: `tabstop=4`, `shiftwidth=4`, and `expandtab`. |
| Display | Absolute and relative numbers, current-line highlight, no wrapping, and a 120-column guide. |
| Files | No swap files or backups; Neovim's `autowrite` option is enabled. |
| Whitespace | Trailing whitespace is removed whenever any buffer is written. |
| Interface | True colour, automatic sign column, and a global status line. |
| Redo | `U` is remapped to redo (`Ctrl-r`); `Ctrl-r` is live grep. |
| Visual `x` | Deletes the selection. |
| `Space l` | Clear search highlighting. |

Autosave is implemented but disabled. Add this to `lua/custom/init.lua` to
enable it:

```lua
vim.mach_opts.mach_builtins.autosave.enabled = true
```

When enabled, modified ordinary file buffers are saved 300 ms after a text
change and display a notification. This is separate from Neovim's `autowrite`.

## Dashboard, commands, and customization

On the dashboard, use `p` for files, `r` for recent files, `t` for the floating
terminal, `n` for a new buffer, `u` for `:Update`, or `q` to quit.

| Command | Action |
|---|---|
| `:Projects` | File picker rooted at `~/Projects`. |
| `:Papers` | File picker rooted at `~/papers`. |
| `:Notes` | File picker rooted at `~/notes`. |
| `:Man` | Search manual pages. |
| `:Chrome` | Open Google with the system `open` command. |
| `:Ports` | In tmux only, open a tmux pane listing listening network ports. |
| `:MachValidateOpts` | Check option tables for enabled Mach components. |

The collection commands require their directories to exist. `:Ports` requires
tmux and `lsof`.

Put personal Lua configuration in `lua/custom/init.lua`. It is loaded after the
core configuration and plugins. Main options are in
`lua/mach/user-plugin-opts.lua`, mappings in `lua/mach/keymaps.lua`, and
language-server configurations in `lsp/`. Restart Neovim after configuration
changes.

If a feature is unavailable:

1. Run `:checkhealth` for missing providers or executables.
2. Use `:Lazy` to check plugin installation.
3. Use `:Mason` to install the relevant server.
4. Run `:LspInfo` in the affected buffer to verify server attachment.
5. Check the current working directory: pickers, Git actions, caches, and
   several LSPs depend on it.
