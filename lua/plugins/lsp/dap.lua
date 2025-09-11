local function exe_name(name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. name
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        {
            "<Leader>Db",
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = "toggle_breakpoint",
        },
        {
            "<Leader>Dc",
            function()
                require('dap').continue()
            end,
            desc = "start or resume debugger",
        },
        {
            "<Leader>n",
            function()
                require('dap').step_over()
            end,
            desc = "step over",
        },
        {
            "<Leader>i",
            function()
                require('dap').step_into()
            end,
            desc = "step into",
        },
        {
            "<Leader>o",
            function()
                require('dap').step_out()
            end,
            desc = "step out",
        },
        {
            "<Leader>Dr",
            function()
                require('dap').repl.open()
            end,
            desc = "open debugger repl",
        },
    },
    config = function()
        local dap = require("dap")
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                command = exe_name('codelldb'),
                args = { "--port", "${port}" },
            }
        }

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = 'OpenDebugAD7',
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = function()
                    local args_string = vim.fn.input("Arguments: ")
                    return vim.split(args_string, " +")
                end,
            },
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = function()
                    -- Prompt for a single line of arguments
                    local args_string = vim.fn.input("Arguments: ")
                    -- Use vim.split to handle space-separated arguments
                    return vim.split(args_string, " +")
                end,
            },
        }


        local dapui = require("dapui")
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
