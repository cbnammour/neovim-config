-- lua/nix/lsp.lua  (Neovim 0.11+)
-- LSP servers: Lua (lua_ls) and TypeScript/JavaScript (tsserver)

-- -------------------------------
-- Common on_attach: keymaps + inlay hints
local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map('n', 'gd', vim.lsp.buf.definition,        'LSP: Go to definition')
  map('n', 'gr', vim.lsp.buf.references,        'LSP: References')
  map('n', 'gD', vim.lsp.buf.declaration,       'LSP: Declaration')
  map('n', 'gi', vim.lsp.buf.implementation,    'LSP: Implementation')
  map('n', 'K',  vim.lsp.buf.hover,             'LSP: Hover')
  map('n', '<leader>rn', vim.lsp.buf.rename,    'LSP: Rename symbol')
  map('n', '<leader>ca', vim.lsp.buf.code_action,'LSP: Code action')
  map('n', '[d', vim.diagnostic.goto_prev,      'Prev diagnostic')
  map('n', ']d', vim.diagnostic.goto_next,      'Next diagnostic')

  if vim.lsp.inlay_hint then pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr }) end
end

-- Optional: format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true }),
  callback = function(args)
    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    for _, c in ipairs(clients) do
      if c.server_capabilities and c.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
        break
      end
    end
  end,
})

-- -------------------------------
-- Lua LSP
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  },
})

-- -------------------------------
-- TypeScript / JavaScript LSP
vim.lsp.config('tsserver', {
  on_attach = on_attach,
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript','typescriptreact','javascript','javascriptreact' },
  root_markers = { 'package.json','tsconfig.json','jsconfig.json','.git' },
  -- formatting usually done by external tools (Prettier, Biome)
})

-- -------------------------------
-- Enable both
vim.lsp.enable({ 'lua_ls', 'tsserver' })

