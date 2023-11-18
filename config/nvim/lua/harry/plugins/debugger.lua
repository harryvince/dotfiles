return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        { 'mfussenegger/nvim-dap' },           -- Required
        { "jay-babu/mason-nvim-dap.nvim" },    -- Required
        { 'theHamsta/nvim-dap-virtual-text' }, -- Optional
    },
    event = 'VeryLazy',
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
            ensure_installed = { "js", "python" }
        })

        -- Python
        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = 'debugpy-adapter',
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end

        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch',
                name = "Launch file",

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return os.getenv('HOME') ..
                        '/.local/share/nvim/mason/packages/jedi-language-server/venv/bin/python'
                    end
                end,
            },
        }

        -- Node
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
