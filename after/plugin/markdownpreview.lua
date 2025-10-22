-- Add leader md shortcut to open Markdown Preview
vim.api.nvim_set_keymap('n', '<leader>md', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })
