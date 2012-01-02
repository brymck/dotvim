"------------------------------------------------------------------------------
" Pathogen
"------------------------------------------------------------------------------
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
" Turn off vi compatibility
set nocompatible
source $VIMRUNTIME/mswin.vim

" Enable filetype and indent plugin
filetype plugin on
filetype indent on

" Set to autoread when file is changed from outside
set autoread

" Enable handling of multiple buffers
set hidden

" Keep a longer history of commands (defaults to 20)
set history=1000

" Extended % matching
runtime macros/matchit.vim

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
" Set leader to comma (instead of backslash)
let mapleader = ","

" Fast editing and updating of .vimrc
nmap <leader>e :e! ~/.vim/vimrc
autocmd! bufwritepost vimrc source ~/.vimrc

"------------------------------------------------------------------------------
" Indent
"------------------------------------------------------------------------------
set autoindent               " Automatically indent
set expandtab                " Use spaces instead of tabs
set smartindent              " Smartly insert an extra level of indentation
set softtabstop=2            " Indent two spaces when pressing tab
set shiftwidth=2             " Indent two spaces
set showmatch                " Jump to match when found

set ruler                    " Show line number
set nowrap                   " Don't wrap text
set incsearch                " Search incrementally
set hlsearch                 " Highlight search results
set mat=2                    " How many tenths of a second to blink

set linebreak                " Break on word barriers
set showbreak=>>>            " Line break shown as >>>

" Turn off search highlighting if it gets annoying
nmap <silent> <leader>n :silent :nohlsearch<CR>

" No sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

"------------------------------------------------------------------------------
" Language
"------------------------------------------------------------------------------
" Use Unicode if multi-byte is available
if has("multi_byte")
  " Make sure terminal encoding is set
  if &termencoding == ""
    let &termencoding = &encoding
  endif

  " Use UTF-8, but allow some other common encodings
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8,utf-16,sjis,latin1,ucs-bom

  " Make non-ASCII glyphs double width; necessary for CJK
  set ambiwidth=double
endif

" Remap ¥ to \ for command line
cnoremap ¥ <Bslash>

" Retain input method editor memory for each mode
set noimd

"------------------------------------------------------------------------------
" Colors and fonts
"------------------------------------------------------------------------------
syntax enable
set t_Co=256
colorscheme candycode
map <silent><F2> :PREVCOLOR<CR>
map <silent><F3> :NEXTCOLOR<CR>
if has("win32")
  set guifont=Consolas:h10:cANSI
else
  set guifont=Monaco:h13
endif

"------------------------------------------------------------------------------
" Files
"------------------------------------------------------------------------------
set nobackup                   " Don't create a permanent backup when writing
set nowritebackup              " Don't make a temporary backup either
set noswapfile                 " Don't use a swapfile for the buffer

" Easily switch between buffers buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
map <leader>, :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" LaTeX
"------------------------------------------------------------------------------
set shellslash                 " For Win32
set grepprg=grep\ -nH\ $*      " Always generate a filename
let g:tex_flavor='latex'       " Default to LaTeX instead of PlainTeX

"------------------------------------------------------------------------------
" Regular expressions
"------------------------------------------------------------------------------
" Default searches to very magic (special characters don't need escaping)
nnoremap / /\v/<Left>
nnoremap ? ?\v/<Left>
nnoremap <leader>/ :%s/\v/g<Left><Left>
nnoremap <leader>j :%s/\v[^\x00-\xff]/&/gn<CR>

" Case-insensitive unless capital letter is included
set ignorecase
set smartcase

" Notify how many replacements were made
set report=0

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
" Show red line after 80 characters
set colorcolumn=80

" Quick remapping for colored column
nnoremap <leader>c :set colorcolumn=0<Left>

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

"------------------------------------------------------------------------------
" Translation
"------------------------------------------------------------------------------
