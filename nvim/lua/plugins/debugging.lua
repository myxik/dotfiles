return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            require("dapui").setup()
            require("dap-python").setup("uv")
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

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<leader>dc", dap.continue, {})
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    },
    {
        'mfussenegger/nvim-dap-python'
    }
}
