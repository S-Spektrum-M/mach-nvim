require('mach.functions')

local function cmd(alias, command)
    return vim.api.nvim_create_user_command(alias, command, { nargs = 0 })
end

cmd("Projects", function() Snacks.picker.files({ cwd = "~/projects", title = "Projects", }) end)
cmd("Papers", function() Snacks.picker.files({ cwd = "~/papers", title = "Papers", }) end)
cmd("Papers", function() Snacks.picker.files({ cwd = "~/notes", title = "Notes", }) end)
cmd("Update", function()
    vim.cmd(":Lazy update")
    vim.cmd(":TSUpdate")
    vim.cmd(":MasonInstall bash-language-server clangd deno gopls json-lsp lua-language-server python-lsp-server rust-analyzer taplo texlab yaml-language-server zls harper-ls")
end)
cmd("Chrome", function() vim.fn.system({ "open", "https://www.google.com" }) end)
cmd("TexRender", ":call RenderLaTexFast()")
cmd("View", ":lua ViewPdf()")
cmd("Man", function() Snacks.picker.man() end)

if os.getenv("TMUX") then
    -- see what ports are open on system; useful for testing APIs
    cmd("Ports", "silent exec \"!tmux split-window -h 'lsof -i -P -n | grep LISTEN; read'\"")
end

