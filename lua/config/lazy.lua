-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return require('lazy').setup({

    { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin-macchiato')
        end
    },

    'mbbill/undotree',
    'tpope/vim-fugitive',
    'theprimeagen/harpoon',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- Autoclose Brackets Plugin
    'm4xshen/autoclose.nvim',

    'alvan/vim-closetag',

    -- Statusbar at bottom
    'itchyny/lightline.vim',

    -- Go.nvim
    'ray-x/go.nvim',
    'ray-x/guihua.lua',

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    },

    {
        "kylechui/nvim-surround",
        tag = "v3.1.2", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = 'v0.*',

        opts = {
            keymap = { 
                preset = 'default',
                ['<Tab>'] = { 'accept', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            signature = { enabled = true }
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilites = capabilities }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local c = vim.lsp.get_client_by_id(args.data.client_id)
                    if not c then return end

                    if vim.bo.filetype == "lua" then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer" },
        },
    }
})
