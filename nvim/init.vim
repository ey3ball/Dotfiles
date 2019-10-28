let g:loaded_python_provider = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:erlang_completion_preview_help = 0

call plug#begin("~/.config/nvim/plugins")
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/erlang-motions.vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

set expandtab
set shiftwidth=4
set tabstop=4
set textwidth=79

autocmd FileType c set noexpandtab tabstop=8 shiftwidth=8 textwidth=80
autocmd FileType Makefile set noexpandtab 
autocmd FileType erlang set expandtab tabstop=4 shiftwidth=4 textwidth=79

set nu

" A bunch of remaps to make vim command mode more readline-like
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Map Esc so that is exits terminal mode
tnoremap <Esc> <C-\><C-n>
