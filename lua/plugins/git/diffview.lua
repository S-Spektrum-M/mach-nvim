return {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
        { "<Leader>dt", "<cmd>CodeDiff<CR>",         desc = "Toggle Git Explorer (CodeDiff)" },
        { "<Leader>dh", "<cmd>CodeDiff history<CR>", desc = "File History (CodeDiff)" },
        { "<Leader>dc", "<cmd>CodeDiff HEAD<CR>",    desc = "Compare with HEAD (CodeDiff)" },
    },
    opts = {
        diff = {
            layout = "side-by-side",
            compute_moves = true,
            disable_inlay_hints = true,
            hide_merge_artifacts = true,
        },
        explorer = {
            view_mode = "tree",
            flatten_dirs = true,
            position = "left",
        },
        history = {
            position = "bottom",
        },
    },
}
