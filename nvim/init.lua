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

    'ibhagwan/fzf-lua';
        'nvim-tree/nvim-web-devicons'; -- depedency

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

vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

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
