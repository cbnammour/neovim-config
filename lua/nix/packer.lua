-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
    use { 'williamboman/mason.nvim', config = function() require('mason').setup() end }
    use {
        'zbirenbaum/copilot.lua',
        config = function()
            require('copilot').setup({
                panel = { enabled = false }, -- keep UI minimal
                suggestion = {
                    enabled = true,
                    auto_trigger = true, -- show as you type
                    debounce = 75,
                    keymap = {
                        accept = "<C-l>",  -- accept suggestion
                        next = "<M-]>",    -- next suggestion
                        prev = "<M-[>",    -- previous suggestion
                        dismiss = "<C-]>", -- hide
                        -- accept_word = false,   -- you can map these if you want:
                        -- accept_line = false,
                    },
                },
                filetypes = {
                    markdown = true, -- enable in md if you like
                    gitcommit = true,
                    ["*"] = true,
                },
            })
        end
    }
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Completion core + sources
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'

    -- Snippets (recommended)
    use { 'L3MON4D3/LuaSnip', tag = 'v2.*', run = 'make install_jsregexp' }
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Parethesis automatic closing
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- enable Tree-sitter integration for smarter pairs
                fast_wrap = {},
            })
        end
    }
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
end)
