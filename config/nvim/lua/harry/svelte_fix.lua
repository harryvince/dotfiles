local M = {}

function M.svelteFix()
    local clients = vim.lsp.get_active_clients()
    for _, found_client in ipairs(clients) do
        if found_client.name == 'svelte' then
            vim.cmd("LspRestart " .. found_client.id)
            break
        end
    end
end

return M
