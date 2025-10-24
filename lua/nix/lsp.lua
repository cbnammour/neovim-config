-- lua/nix/lsp.lua  (Neovim 0.11+)

-- If Mason is installed, prefer its binaries; otherwise fall back to system PATH
local function mason_cmd(name)
    local path = vim.fn.stdpath("data") .. "/mason/bin/" .. name
    return (vim.fn.executable(path) == 1) and path or name
end

-- Per-buffer keymaps
local function on_attach(_, bufnr)
    local map = function(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc }) end
    map('n', 'gd', vim.lsp.buf.definition, 'LSP: definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'LSP: declaration')
    map('n', 'gr', vim.lsp.buf.references, 'LSP: references')
    map('n', 'gi', vim.lsp.buf.implementation, 'LSP: implementation')
    map('n', 'K', vim.lsp.buf.hover, 'LSP: hover')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: rename')
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: code action')
    map('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

    -- inlay hints (handle both 0.10 and 0.11+ signatures safely)
    if vim.lsp.inlay_hint and type(vim.lsp.inlay_hint.enable) == 'function' then
        local ok = pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
        if not ok then pcall(vim.lsp.inlay_hint.enable, bufnr, true) end
    end
end

-- Optional: format on save (only if the server supports it)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
end)

-- Lua (lua-language-server)
vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { mason_cmd('lua-language-server') },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' }, -- markers to detect project root
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        }
    },
})

-- TypeScript / JavaScript (typescript-language-server)
vim.lsp.config('tsserver', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { mason_cmd('typescript-language-server'), '--stdio' },
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
})

-- C (clangd)
vim.lsp.config('clangd', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { mason_cmd('clangd') },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
})

-- Go (gopls)
vim.lsp.config('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { mason_cmd('gopls') },
    filetypes = { 'go', 'gomod' },
    root_markers = { 'go.mod', '.git' },
})


-- nim language server nimlanguageserver from mason
vim.lsp.config('nimlangserver', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { mason_cmd('nimlangserver') },
    filetypes = { 'nim' },
    root_markers = { 'nim.cfg', '.git' },
})

-- Enable both (names must MATCH the first arg to vim.lsp.config)
vim.lsp.enable({ 'lua_ls', 'tsserver', 'clangd', 'gopls', 'nimlangserver' })
