local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

require 'paq' {
    'savq/paq-nvim';
    'neovim/nvim-lspconfig';
    'glepnir/lspsaga.nvim';
    'nvim-treesitter/nvim-treesitter';
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',


    'ibhagwan/fzf-lua';
        'nvim-tree/nvim-web-devicons'; -- depedency

    -- telescope and dependencies
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


local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = { },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

---- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--  sources = cmp.config.sources({
--    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--  }, {
--    { name = 'buffer' },
--  })
--})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require 'rust-tools'.setup({
    --tools = {
    --    autoSetHints = false,
    --},
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
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

require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require 'lspconfig'.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {"yaml", "yml"};
}
require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
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
opt.formatoptions = "c"
--opt.formatoptions = "tc"

g.mapleader = ','
g.lightline = {
    active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'relativepath', 'modified' } } },
    component_function = { gitbranch = "FugitiveHead" },
}
