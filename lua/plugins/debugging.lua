return {
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.configurations.java = {
                {
                    type = "java",
                    request = "launch",
                    name = "Debug (Attach)",
                    hostName = "127.0.0.1";
                    port = 5005,
                },
            }

            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>dc", dap.continue)
        end
    },
}
