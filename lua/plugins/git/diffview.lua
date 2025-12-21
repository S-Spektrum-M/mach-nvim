return
{
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
        { "<Leader>dt", "<cmd>CodeDiff<CR>",  desc = "Toggle Diff View" },
    }
}
