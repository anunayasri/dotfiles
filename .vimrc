" long live vim
"
set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" color schemes
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sickill/vim-monokai'

" plugins
"Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'tpope/vim-fugitive'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-rails'
Plugin 'vim-airline/vim-airline'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'airblade/vim-gitgutter'
Plugin 'tomtom/tcomment_vim'
"Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'scrooloose/syntastic'
"Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
"Plugin 'tpope/vim-ragtag'
"Plugin 'sukima/xmledit'
" Plugin 'vim-scripts/FuzzyFinder'

" syntax files
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'voithos/vim-python-syntax'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'derekwyatt/vim-scala'
"Plugin 'groenewege/vim-less'
"Plugin 'leafgarland/typescript-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elzr/vim-json'
Plugin 'chase/vim-ansible-yaml'
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
" In a codebase that uses 4 space characters for each indent, here are good settings to start with
set tabstop=2 " show existing tab with 4 spaces width
set softtabstop=0 smarttab
set shiftwidth=2 " when indenting with '>'
set expandtab " On pressing tab, insert 4 spaces

" Tab settings according to filetype
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype eruby setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Powerline settings
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'

" syntax highlighting and auto-indentation
syntax on
filetype on
filetype indent on
filetype plugin on
inoremap # X<C-H>#
set ai
set si
set cursorline                  " highligt current line

set laststatus=2                " Always show statusline
" set mouse=a                     " Automatically enable mouse usage
set hlsearch
colorscheme monokai

" Set <leader> key
let mapleader=","

" Key bindings

" Enter new line without exiting the normal mode
" nmap <S-Enter> O<Esc>
" nmap <CR> o<Esc>

" Toggle paste mode
set pastetoggle=<F2>

" Quickly switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" FuzzyFinder mappings
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" CtrlP : Enter opens the selected file in a tab and CTRL-T opens in the same tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" Copy to and paste from clipboard
set clipboard=unnamedplus
" NERDTree settings
map <C-\> :NERDTreeToggle<CR>
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
vnoremap <c-/> :TComment<cr>

" easy movement in the page
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

" copy current files path to clipboard
nmap cp :let @+ = expand("%") <cr>
