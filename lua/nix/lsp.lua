-- lua/nix/lsp.lua (Neovim 0.11+)
local function on_attach(_, bufnr)
	local map = function(m, l, r, d) vim.keymap.set(m, l, r, { buffer = bufnr, desc = d }) end
	map('n', 'gd', vim.lsp.buf.definition, 'LSP: definition')
	map('n', 'gr', vim.lsp.buf.references, 'LSP: references')
	map('n', 'K', vim.lsp.buf.hover, 'LSP: hover')
	map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: rename')
	map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: code action')
	map('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
	map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
	if vim.lsp.inlay_hint then pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr }) end
end

-- format on save if server supports it
vim.api.nvim_create_autocmd('BufWritePre', {
	group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true }),
	callback = function(args)
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.server_capabilities and c.server_capabilities.documentFormattingProvider then
				vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
				break
			end
		end
	end,
})

-- Lua
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

-- TypeScript / JavaScript
vim.lsp.config('tsserver', {
	on_attach = on_attach,
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
})

vim.lsp.enable({ 'lua_ls', 'tsserver' })
