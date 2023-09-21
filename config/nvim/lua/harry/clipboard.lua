if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy = { ["+"] = { "/mnt/c/Windows/System32/clip.exe" }, ["*"] = { "/mnt/c/Windows/System32/clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end
