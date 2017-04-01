set nocompatible              " required
" filetype off                  " required
syntax on
syntax enable

" Monokai color scheme
" mkdir -p ~/.vim/colors
" wget https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -P ~/.vim/colors
colorscheme monokai

" Solarized color scheme
" colorscheme solarized

" utf-8/cp949 support
set encoding=utf-8
set fileencodings=utf-8,cp949

" Line numbering
set nu 

" Tab = 4 spaces
set ts=4

" Smart Indentation
" set smartindent

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Install Vundle if not installed
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" File Browsing (Nerd Tree)
Plugin 'scrooloose/nerdtree'
let NERDTreeWinPos = "left"
let mapleader = "," " remaps leader key to ','
noremap <Leader>rc :rightbelow vnew $MYVIMRC<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <C-F> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

" Searching with Ctrl-P
Plugin 'kien/ctrlp.vim'

" Auto-completion
Plugin 'Valloric/YouCompleteMe'

" Sync Clipboard
set clipboard=unnamed

""""""""""""""""""""""""""""""""""" 
"             Python              "
"""""""""""""""""""""""""""""""""""
let python_highlight_all=1

" Prompt to run Python script by <F2>
au FileType python map <F2> : !python %:p 
" Save and Run Python script by <F9>
nnoremap <silent> <F9> :!clear;python %:p<CR>

" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'
set rtp+=Users/home/jmin/anaconda3/lib/python3.5/dist-packages/powerline/bindings/vim/
set laststatus=2

" Python Syntax/Highlighting
Plugin 'scrooloose/syntastic'

" Python Syntax/Style checker
" pip install flake8
Plugin 'nvie/vim-flake8' " <F7>

" Python Auto-indent
Plugin 'vim-scripts/indentpython.vim'

" Python commenter
Plugin 'scrooloose/nerdcommenter'

""""""""""""""""""""""""""""""""""" 
"           JavaScript            "
"""""""""""""""""""""""""""""""""""
" JavaScript Syntax, Highliting and Indentation
Plugin 'pangloss/vim-javascript'
Plugin 'crusoexia/vim-javascript-lib'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
