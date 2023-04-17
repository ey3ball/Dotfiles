local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

require 'paq' {
    'savq/paq-nvim';
    'neovim/nvim-lspconfig';
    'glepnir/lspsaga.nvim';
    'hrsh7th/nvim-compe';
    'nvim-treesitter/nvim-treesitter';

    -- telescope and dependencies
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    -- statusline
    'itchyny/lightline.vim';

    -- git
    'nvim-lua/plenary.nvim';
    'lewis6991/gitsigns.nvim';
    'tpope/vim-fugitive';

    -- rust
    'simrat39/rust-tools.nvim';
    'mfussenegger/nvim-dap';
}

require 'compe'.setup({
    enabled = true;
    autocomplete = true;
    documentation = true;
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        nvim_lua = true;
    };
})

require 'rust-tools'.setup({
    --tools = {
    --    autoSetHints = false,
    --},
    server = {
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = false
                },
                diagnostics = {
                    disabled = {"macro-error", "unresolved-proc-macro"}
                },
            },
        },
    },
})

require 'lspconfig'.pyright.setup {}
require 'lspconfig'.yamlls.setup {
    filetypes = {"yaml", "yml"};
}
require 'nvim-treesitter.configs'.setup{
    ensure_installed = { "lua" };
    highlight = {enable = true}
}

local saga = require 'lspsaga'.setup({})

vim.cmd[[ highlight GitSignsAdd    guifg=green ]]
vim.cmd[[ highlight GitSignsChange guifg=orange ]]
vim.cmd[[ highlight GitSignsDelete guifg=red ]]
vim.cmd[[ highlight SignColumn guibg=none ]]
vim.cmd[[ highlight Pmenu ctermbg=gray guibg=gray ]]
vim.cmd[[ set pumblend=15 ]]

require('gitsigns').setup()

vim.o.completeopt = "menuone,noselect"

--vim.cmd 'colorscheme koehler' 
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.textwidth = 79
opt.smartindent = true
opt.termguicolors = true

g.mapleader = ','
g.lightline = {
    active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'relativepath', 'modified' } } },
    component_function = { gitbranch = "FugitiveHead" },
}
