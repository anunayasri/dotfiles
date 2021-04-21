" long live vim
"
set encoding=utf-8
set nocompatible              " be iMproved, required
set autoread                  " detect when a file is changed
set t_Co=256                  " to show 256 colors
set linespace=3               " applicable only for GUI vim

" Set <leader> key
let mapleader=" "

set history=1000              " change history to 1000
" set textwidth=120

" Where should the new splits appear
set splitbelow
set splitright

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" enable 24 bit color support if supported
" if (has("termguicolors"))
    " set termguicolors
" endif

" vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" color schemes
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sickill/vim-monokai'
Plugin 'morhetz/gruvbox'

" plugins
Plugin 'ryanoasis/vim-devicons'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-rails'
Plugin 'vim-airline/vim-airline'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'airblade/vim-gitgutter'
Plugin 'tomtom/tcomment_vim'
"Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
"Plugin 'tpope/vim-ragtag'
"Plugin 'sukima/xmledit'
" Plugin 'vim-scripts/FuzzyFinder'
Plugin 'tpope/vim-surround'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-unimpaired'

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
Plugin 'Yggdroot/indentLine'
Plugin 'vim-scripts/searchfold.vim'
Plugin 'Valloric/YouCompleteMe'
Bundle 'davidhalter/jedi-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

set guifont = "SauceCodePro Nerd Font Mono:h11"

set number                  " show line numbers

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
autocmd Filetype eruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Powerline settings
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1       " enable tabline
let g:airline#extensions#tabline#show_buffers = 0  " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 1        " disable fugitive integration
let g:airline_section_y = ''
let g:airline_theme='molokai'
let g:airline#extensions#tabline#fnamemod = ':t'   " Just show the filename (no path) in the tab"

" syntax highlighting and auto-indentation
syntax on
filetype on
filetype indent on
filetype plugin on
inoremap # X<C-H>#
set ai
set si
set cursorline              " highligt current line

set autoindent              " automatically set indent of new line
set smartindent

set laststatus=2            " Always show statusline
" set mouse=a               " Automatically enable mouse usage

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set nolazyredraw            " don't redraw while executing macros
set list listchars=trail:·,tab:▸·,extends:»,precedes:«
"redraws the screen and removes any search highlighting
nnoremap <leader>c :nohl<CR>

set background=dark         " use dark mode in color scheme
colorscheme gruvbox

" shortcut to save
noremap <leader>, :w<cr>

" Enter new line without exiting the normal mode
" nmap <S-Enter> O<Esc>
" nmap <CR> o<Esc>


set pastetoggle=<leader>v   " Toggle paste mode

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>  

" Quickly switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" FuzzyFinder mappings
" nmap ,f :FufFileWithCurrentBufferDir<CR>
" nmap ,b :FufBuffer<CR>
" nmap ,t :FufTaggedFile<CR>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" CtrlP : Enter opens the selected file in a tab and CTRL-T opens in the same tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
nnoremap <leader>t :CtrlP<CR>
" CtrlP ignore files in .gitignore
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" Ignore files listed in gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Copy to and paste from clipboard
" set clipboard=unnamedplus
set clipboard+=unnamed

" NERDTree settings
map <C-\> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
vnoremap <C-/> :TComment<cr>

" easy movement in the page
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

" scroll the viewport faster
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

" copy current files path to clipboard
nmap cp :let @+ = expand("%") <cr>

" Code folding
set foldmethod=indent
set foldlevel=99

" Config for ack.vim to use 'ag' instead of 'ack'
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

nnoremap <Leader>a :Ack!<Space>

" config for syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"
" Python/Djagno code specific settings
"
" YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set tags=tags
autocmd BufWritePost *.py silent! !ctags -R --python-kinds=-i --languages=python > /dev/null 2>&1 &

let g:jedi#use_splits_not_buffers = "top"
let g:jedi#goto_definitions_command = "<leader>j"
