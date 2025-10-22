vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp then return end

local ok_ls, luasnip = pcall(require, 'luasnip')
if ok_ls then
    -- load VSCode-style snippets on demand (from friendly-snippets)
    pcall(function() require('luasnip.loaders.from_vscode').lazy_load() end)
end

cmp.setup({
    snippet = {
        expand = function(args)
            if ok_ls then luasnip.lsp_expand(args.body) end
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }), -- accept first item on Enter
        ['<Tab>']     = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif ok_ls and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>']   = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ok_ls and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})
