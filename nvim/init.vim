" long live vim
"

" {{{ Native vim config
syntax on
filetype plugin on

set encoding=utf-8
set nocompatible              " be iMproved, required
set autoread                  " detect when a file is changed
" set t_Co=256                  " to show 256 colors
set linespace=3               " applicable only for GUI vim

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=3
set cursorline
set list listchars=trail:·,tab:▸·,extends:»,precedes:«
set wildmenu
set wildmode=full

" Open the buffer is a new tab
set switchbuf=usetab,newtab

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Set <leader> key
let mapleader=" "

set history=1000              " change history to 1000
" set textwidth=120

" Where should the new splits appear
set splitbelow
set splitright

set termguicolors

set guicursor=i:ver25-iCursor     " Set cursor as vertical line in insert mode

" Easy tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" shortcut to save
" nnoremap <leader>w :w<cr>

" Edit nvim config
noremap <Leader>ev :tabe ~/.config/nvim/init.vim<CR>

" Reload the nvim config
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" Save the file
noremap <Leader>s :w<CR>

" Enter a new line below in normal mode
noremap <Leader>o o<ESC>k

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Easy movement in the page
noremap H ^
noremap L g_
noremap <C-j> 5j
noremap <C-k> 5k

" Search and fold other lines
command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2

" }}}

" vundle
filetype off
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

call plug#begin("~/.vim/plugged")

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'dbridges/vim-markdown-runner'

" color schemes
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line

call plug#end()
" call vundle#end()            " required

colorscheme gruvbox
set background=dark

" {{{ Custom mappings & commands

nnoremap <Leader>ex ::CocCommand explorer<CR>

nnoremap <leader>f :Rg<SPACE>
nnoremap <C-p> :GFiles --cached --others<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>pb :Buffers<CR>
nnoremap <Leader>q :Buffers<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" command! Run :w | sp<CR> | term python3 %<CR>
" command! Do :sp<CR> | term ls shellescape(@%, 1)<CR>
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd! FileType python nnoremap <buffer> <leader>e :w<CR> :sp<CR> :term python3 %<CR>

" }}}

" let g:vim_markdown_fenced_languages = ['py=python']
let g:vim_markdown_new_list_item_indent = 2
let g:markdown_folding = 1
let g:vim_markdown_frontmatter = 1

" g:ale_sql_sqlfmt_executable = '/Users/anunayasri/.pyenv/versions/3.6.0/envs/hc-onlinejudge-v2/bin/sqlformat'

" {{{ Prettier settings using ale
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'json': ['prettier'],
\   'python': ['black'],
\   'sql': ['sqlformat'],
\   'erlang': ['erlc'],
\}

let g:ale_lint_on_enter = 0
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:erlang_show_errors = 0

nnoremap <Leader>af :ALEFix<CR>

" }}}

" {{{ VimWiki settings
let g:vimwiki_list = [
\   {
\       'path': '~/vimwiki/',
\       'ext': '.md',
\       'automatic_nested_syntaxes': 1,
\   }
\]

let g:vimwiki_listsyms = '✗○◐●✓'

" }}}

" {{{ NerdCommenter Settings

" Create default mappings
let g:NERDCreateDefaultMappings = 0

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Add space after the comment symbol
let g:NERDSpaceDelims=1

map <Leader>cc <Plug>NERDCommenterToggle

" }}}

" {{{ iamcco/markdown-preview.nvim Settings

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 1
let g:mkdp_markdown_css = expand('~/.local/lib/github-markdown-css/github-markdown.css')
" }}}
