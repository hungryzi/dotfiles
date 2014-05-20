set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'bling/vim-airline'

" Perform indentation based on filetype
filetype plugin indent on     " required! for vundle

" Open NERDTree when vim starts
autocmd vimenter * if !argc() | NERDTree | endif

" Colorscheme
colorscheme railscasts

" Set font size to 12
set guifont=Monaco:h12

" Enable softtab
" Set tabsize to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Autoindent
set autoindent

" Autosave
:au FocusLost * silent! wa

" Map NERDTreeToggle
:nmap <C-o> :NERDTreeToggle<CR>

" Disable swap files
set noswapfile

" Show line numbers
set number

