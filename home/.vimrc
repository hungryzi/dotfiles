" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Editing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-rsi'
Plug 'christoomey/vim-tmux-navigator'

" Frameworks & languages
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'

" Syntax
Plug 'neomake/neomake'
Plug 'tomlion/vim-solidity'

" Test
Plug 'janko-m/vim-test'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'

" Directory
Plug 'scrooloose/nerdtree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Themes
Plug 'chriskempson/base16-vim'

call plug#end()

" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_open_list = 2

" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" Fuzzy search with Ctrl-P
nnoremap <C-p> :FZF<CR>

" Ag searches from project root
let g:ag_working_path_mode="r"
let g:vim_action_ag_escape_chars = '#%.^$*+?()[{\\|'
" use Ctrl-F to search current word in normal mode
nmap <C-f> <Plug>AgActionWord
" use Ctrl-F to search selected text in visual mode
vmap <C-f> <Plug>AgActionVisual

" Theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow-night

" Completion
let g:deoplete#enable_at_startup = 1

" Test
let test#strategy = "make"

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Tree
map <C-t> :NERDTreeToggle<CR>
map <C-n> :NERDTreeFind<CR>

"General
syntax on
set number
filetype plugin indent on
set nocp
set ruler
set wildmenu
set mouse-=a
set t_Co=256
set list
"Code folding
set foldmethod=manual
"Tabs and spacing
set autoindent
set cindent
set tabstop=2
set expandtab
set shiftwidth=4
set smarttab
"Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set diffopt+=iwhite
