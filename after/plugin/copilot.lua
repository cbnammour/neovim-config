vim.keymap.set('n', '<leader>ct', function()
    local output = vim.fn.system("echo | copilot status 2>/dev/null | grep 'Enabled'")
    if output == "" then
        vim.cmd("Copilot enable")
        vim.notify("Copilot Enabled 🟢", vim.log.levels.INFO)
    else
        vim.cmd("Copilot disable")
        vim.notify("Copilot Disabled 🔴", vim.log.levels.WARN)
    end
end, { desc = 'Toggle Copilot (with status)' })
