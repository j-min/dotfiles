set nocompatible

set mouse=a

syntax enable

" Monokai color scheme
colorscheme monokai

" utf-8/cp949 support
set encoding=utf-8
set fileencodings=utf-8,cp949

" Line numbering
set nu 

" Indendations
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

" Sync Clipboard
set clipboard=unnamed

" Directory for plugins
call plug#begin('~/.vim/plugged')

" File Browsing (Nerd Tree)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeWinPos = "left"
let mapleader = "," " remaps leader key to ','
noremap <Leader>rc :rightbelow vnew $MYVIMRC<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <C-F> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Searching with Ctrl-P
Plug 'kien/ctrlp.vim'

" Syntax Check
Plug 'scrooloose/syntastic'

" Dash Plugin
Plug 'rizzatti/dash.vim'
nmap <silent> <leader>c <Plug>DashGlobalSearch
nmap <silent> <leader>v <Plug>DashSearch

""""""""""""""""""""""""""""""""""" 
"             Python              "
"""""""""""""""""""""""""""""""""""
let python_highlight_all=1

" Prompt to run Python script by <F2>
au FileType python map <F2> : !python %:p 
" Save and Run Python script by <F9>
nnoremap <silent> <F9> :!clear;python %:p<CR>

" autocompletion with deocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
let g:deoplete#enable_at_startup = 1

" go-to-definition / refactor
Plug 'davidhalter/jedi-vim'
let g:jedi#usages_command = "<leader>m"

" Powerline
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'
set laststatus=2

" Python Syntax/Style checker
" pip install flake8
Plug 'nvie/vim-flake8', {'for': 'python'} " <F7>

" Python Auto-indent
Plug 'vim-scripts/indentpython.vim', {'for': 'python'}

" Python commenter
Plug 'scrooloose/nerdcommenter', {'for': 'python'}

""""""""""""""""""""""""""""""""""" 
"           JavaScript            "
"""""""""""""""""""""""""""""""""""
" JavaScript Syntax, Highliting and Indentation
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'crusoexia/vim-javascript-lib', {'for': 'javascript'}

" Initialize plugin system
call plug#end()


" All of your Plugins must be added before the following line
filetype plugin indent on    " required
