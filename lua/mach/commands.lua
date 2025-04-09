local function cmd(alias, command)
    return vim.api.nvim_create_user_command(alias, command, {nargs = 0})
end

cmd("Projects", function () require("telescope.builtin").find_files({ cwd = "~/projects", prompt_title = "Projects", }) end)
cmd("Papers", function () require("telescope.builtin").find_files({ cwd = "~/papers", prompt_title = "Papers", }) end)
cmd("Notes", function () require("telescope.builtin").find_files({ cwd = "~/notes", prompt_title = "Notes", }) end)
cmd("Update", function ()
    vim.cmd(":Lazy update")
    vim.cmd(":TSUpdate")
    vim.cmd(":MasonInstall pyright deno json-lsp rust-analyzer gopls ltex-ls texlab")
end)
cmd("Chrome", function() vim.fn.system({"open", "https://www.google.com" }) end)
cmd("TexRender", ":call RenderLaTexFast()")
cmd("View", ":lua ViewPdf()")
cmd("MMan", function () require("telescope.builtin").man_pages() end)

if os.getenv("TMUX") then
    cmd("Ports", "silent exec \"!tmux split-window -h 'lsof -i -P -n | grep LISTEN; read'\"")
    cmd("Diff", "silent exec \"!tmux split-window -h 'git diff; read'\"")
    cmd("Bat", "silent exec \"!tmux split-window -h 'batcat %; read'\"")
end
