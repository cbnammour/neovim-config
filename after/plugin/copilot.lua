-- Enable Copilot globally + attach to buffer
vim.keymap.set('n', '<leader>ce', function()
    vim.cmd("Copilot enable")
    vim.cmd("Copilot enable buffer") -- ensure this buffer is attached
    vim.notify("Copilot Enabled 🟢", vim.log.levels.INFO, { title = "GitHub Copilot" })
end, { desc = 'Enable Copilot' })

-- Disable Copilot globally
vim.keymap.set('n', '<leader>cd', function()
    vim.cmd("Copilot disable")
    vim.notify("Copilot Disabled 🔴", vim.log.levels.WARN, { title = "GitHub Copilot" })
end, { desc = 'Disable Copilot' })
