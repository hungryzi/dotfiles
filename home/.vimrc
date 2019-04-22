" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Editing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-rsi'
Plug 'christoomey/vim-tmux-navigator'

" Frameworks & languages
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'

" Syntax
Plug 'neomake/neomake'
Plug 'tomlion/vim-solidity'
Plug 'lambdalisue/vim-pyenv'
Plug 'HerringtonDarkholme/yats.vim'

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

" Run Neomake when I save any buffer
augroup localneomake
  autocmd! BufWritePost * Neomake
augroup END

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 0
let g:neomake_open_list = 2

let g:neomake_black_maker = {
    \ 'exe': 'black',
    \ 'errorformat': '%f:%l:%c: %m',
    \ }

let g:neomake_python_enabled_makers = ['black']

let g:neomake_typescript_enabled_makers = ['tsc']
let g:neomake_typescript_tsc_exe = $PWD . '/node_modules/.bin/tsc'

if findfile('.eslintrc', '.;') !=# ''
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
  let g:neomake_javascript_eslint_exe = $PWD . '/node_modules/.bin/eslint'
endif

function! FixThis()
  retab
  execute 'normal! mm gg=G `m'
    if (&ft ==# 'javascript')
      :!yarn lint-fix %
    elseif (&ft ==# 'python')
      :!black %
    elseif (&ft ==# 'json')
      :!eslint --fix --plugin json %
    elseif (&ft ==# 'html')
      :! tidy --indent yes --vertical-space no --literal-attributes yes --show-body-only no --indent-spaces 2 --tidy-mark no --wrap 100 %
  endif
  checktime
  Neomake
endfunction
nnoremap <leader>fix :call FixThis()<CR>

" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

if empty($PYENV_ROOT)
  let s:pyenv_root = $HOME . '/.pyenv'
else
  let s:pyenv_root = $PYENV_ROOT
endif

if isdirectory(s:pyenv_root)
  " Add pyenv shims to path.
  let s:pyenv_shims = s:pyenv_root . '/shims'
  let $PATH = substitute($PATH, ':' . s:pyenv_shims, '', '')
  let $PATH .= ':' . s:pyenv_shims
endif

let g:python_host_prog = '/Users/zvu/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/zvu/.pyenv/versions/neovim3/bin/python'

" Fuzzy search with Ctrl-P
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -l --nocolor -g ""'

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

" Undo
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif

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
set hidden " Hide unsaved buffer if open a new file
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
