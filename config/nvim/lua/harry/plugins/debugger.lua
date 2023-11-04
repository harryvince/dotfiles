return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        { 'mfussenegger/nvim-dap' },           -- Required
        { "jay-babu/mason-nvim-dap.nvim" },    -- Required
        { 'theHamsta/nvim-dap-virtual-text' }, -- Optional
    },
    config = function()
        local dap, dapui = require('dap'), require('dapui')
        dapui.setup()
        require("nvim-dap-virtual-text").setup()

        -- Keymaps --
        vim.keymap.set("n", "<leader>du", dapui.toggle)
        vim.keymap.set('n', '<F5>', dap.continue)
        vim.keymap.set('n', '<F1>', dap.step_over)
        vim.keymap.set('n', '<F2>', dap.step_into)
        vim.keymap.set('n', '<F3>', dap.step_out)
        vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
        vim.keymap.set('n', '<F10>', function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end)

        -- Auto opening Debug panel --
        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end

        -- Debuggers
        -- Debugger list: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
        require("mason-nvim-dap").setup({
            ensure_installed = { "js" }
        })

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "js-debug-adapter",
                args = { "${port}" },
            },
        }

        local exts = {
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            -- using pwa-chrome
            'vue',
            'svelte',
        }

        for _, ext in ipairs(exts) do
            dap.configurations[ext] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Program (pwa-node)',
                    cwd = vim.fn.getcwd(),
                    args = { '${file}' },
                    sourceMaps = true,
                    protocol = 'inspector',
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Program (pwa-node with ts-node)',
                    cwd = vim.fn.getcwd(),
                    runtimeArgs = { '--loader', 'ts-node/esm' },
                    runtimeExecutable = 'node',
                    args = { '${file}' },
                    sourceMaps = true,
                    protocol = 'inspector',
                    skipFiles = { '<node_internals>/**', 'node_modules/**' },
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Test Program (pwa-node with jest)',
                    cwd = vim.fn.getcwd(),
                    runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
                    runtimeExecutable = 'node',
                    args = { '${file}', '--coverage', 'false' },
                    rootPath = '${workspaceFolder}',
                    sourceMaps = true,
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                    skipFiles = { '<node_internals>/**', 'node_modules/**' },
                },
                {
                    type = 'pwa-chrome',
                    request = 'attach',
                    name = 'Attach Program (pwa-chrome = { port: 9222 })',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    port = 9222,
                    webRoot = '${workspaceFolder}',
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach Program (pwa-node)',
                    cwd = vim.fn.getcwd(),
                    processId = require('dap.utils').pick_process,
                    skipFiles = { '<node_internals>/**' },
                },
            }
        end
    end
}
