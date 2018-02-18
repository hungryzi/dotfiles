" It's Vim - not Vi
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'corntrace/bufexplorer.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx.git'
Plugin 'sbdchd/neoformat'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'thoughtbot/vim-rspec.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-obsession.git'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-haml'
Plugin 'benmills/vimux'
Plugin 'groenewege/vim-less'
Plugin 'ngmy/vim-rubocop'
Plugin 'powerline/powerline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Prevents some security exploits
set modelines=0

" default encoding
set encoding=utf-8

" enable per-directory .vimrc files
set exrc

" disable unsafe commands in local .vimrc files
set secure

try
  " persistent undo
  set undodir=~/.vim/undofiles
  set undofile
catch
  " Vim < 7.3
endtry

" No backups
set nobackup
set noswapfile

" Hide instad of closing - will not force writes
set hidden

" link unnamed register with the clipboard
if $TMUX == ''
  set clipboard+=unnamed
endif

" enable syntax highlighting
syntax enable

" use 2 spaces for tab
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set smarttab

" make backspace work in insert mode
set backspace=indent,eol,start

" no wrap long lines
set nowrap

" match indentation of previous line
set autoindent

" searching is case sensitive when all lowercase
set ignorecase smartcase

" highlight the search matches
set hlsearch

" show the first match as search strings are typed
set incsearch

" show line numbers
set number numberwidth=2

" Visual
set showmatch

" status line
set laststatus=2
set statusline=%t       "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=[%c,%l] "cursor column
set statusline+=\ %P    "percent through file

" put useful info in status bar
" set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
set statusline+=%#warningmsg#
set statusline+=%*

" colors
set background=dark
if $COLORTERM=='gnome-terminal'
  set term=gnome-256color
  " fix background color see:  http://sunaku.github.io/vim-256color-bce.html
  set t_ut=
end

colorscheme Tomorrow-Night

" Setup font depending on the OS
if has('gui_macvim')
  set guifont=Monaco:h13
elseif has('gui_gnome')
  set guifont=Monospace\ 11
endif

" Hide toolbar
set guioptions-=T

" Show vertical line at 100th column
set colorcolumn=100

" NETRW options
"  - vertical splitting for preview
let g:netrw_preview = 1
"  - "tree" listing style
let g:netrw_liststyle = 3
"  - dir listing width when preview is open
let g:netrw_winsize = 20
" netrw dir browse history
let g:netrw_dirhistmax = 100

" Ruby files
augroup ruby
  autocmd!
  autocmd BufNewFile,BufRead Gemfile,Rakefile,Guardfile,Vagrantfile  set filetype=ruby
augroup END

" Strip trailing whitespace for code files on save
function! StripTrailingWhitespace()
  let save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', save_cursor)
endfunction

augroup trailing_whitespace
  autocmd!
  autocmd FileType ruby,yaml,javascript,css,scss,haml,eco,coffee,python,yaml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
augroup END

" Enable spell check in git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" flip the default split directions to sane ones
set splitright
set splitbelow

" perform indentaion based on filetype plugin
filetype plugin indent on

" enable matchit plugin for better % support in ruby files
runtime macros/matchit.vim

" Key mappings
" dont use arrows!
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" buffer resizing
nnoremap <C-left> :vertical resize -2<cr>
nnoremap <C-right> :vertical resize +2<cr>
nnoremap <C-up> :resize -2<cr>
nnoremap <C-down> :resize +2<cr>

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" make the search highlight disappear after \<space>
nnoremap <silent><Leader><space> :noh<cr>

" toggle cursor line and column
nnoremap <silent><Leader>c :set cursorline! cursorcolumn!<CR>

" NERDTree
nnoremap <silent><Leader>t :NERDTreeToggle<cr>
nnoremap <silent><Leader>f :NERDTreeFind<cr>

" rspec.vim
let g:rspec_command = "Dispatch make rspec {spec}"
nnoremap <Leader>e :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'

" Search
nnoremap <C-f> :Ggr <cword><CR> | cw | redraw!
autocmd QuickFixCmdPost *grep* cwindow

" JSX
let g:jsx_ext_required = 0

" Quit file
noremap <leader>q :q<cr>

" Toggle paste mode
set pastetoggle=<leader>z

" Change pane
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Save file
" nnoremap <leader>s :w<cr>
" inoremap <leader>s <C-c>:w<cr>

" Format on save
autocmd BufWritePre *.js undojoin | Neoformat
" autocmd BufWritePre *.rb undojoin | Neoformat

" Neoformat
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_only_msg_on_error = 1

" ESC delay
set timeoutlen=1000 ttimeoutlen=0

" Powerline
let g:Powerline_symbols = 'fancy'

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" JS folding
augroup javascript_folding
  au!
  au FileType javascript setlocal foldmethod=syntax
augroup END
autocmd Syntax * normal zR
