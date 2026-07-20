return {
    {
        "igorlfs/nvim-dap-view",
        -- let the plugin lazy load itself
        lazy = true,
        version = "1.*",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
        cmd = {
            "DapViewOpen",
            "DapViewClose",
            "DapViewToggle",
            "DapViewHover",
            "DapViewWatch",
        },
    },
}
