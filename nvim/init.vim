call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'connorholyday/vim-snazzy'
Plug 'itchyny/lightline.vim'
Plug 'haishanh/night-owl.vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()
"#######################################################

" Font
set guifont=Monospace:h20

" Use an older version of RegeX, faster
set re=1

" Always use system clipboard no matter what
set clipboard=unnamedplus

" Make Vim buffer the rendered lines
set ttyfast
set lazyredraw

set synmaxcol=128
syntax sync minlines=25

" NERDTree
"    Autostart NERDTree
autocmd vimenter * NERDTree

"    Autostart in edit area
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"	 Open NERDTree binding
map <C-k> :NERDTreeToggle<CR>
"    Open _my-sources folder
map <F10> :NERDTree /home/fhilipe/Scripts/
" Enable line numbers
set number

" Set shell
set shell=fish

" Set encoding
set encoding=utf-8
set fileencoding=utf-8

" Syntax and colors
syntax on

set termguicolors

filetype on
filetype indent on
filetype plugin on
set number
set title
set wrap
set showmode
set ruler
set background=dark
set t_Co=256
set hidden
set cursorline!

" Tabs and spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Stuff
set textwidth=120
set ffs=unix,dos,mac
set backspace=indent,eol,start

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set history=500
set undolevels=700
set wrapscan

" Bind <F3> to clear search history "
map <F3> *:let @/=""

colorscheme night-owl

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'snazzy',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator':    { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }