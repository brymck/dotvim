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

" Rehighlight text after indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Rapidly toggle invisible characters, using same symbols as TextMate
nnoremap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

"------------------------------------------------------------------------------
" tabular
"------------------------------------------------------------------------------
" Shortcuts for aligning tables with common delimiters
if exists(":Tabularize")
  " Vertical bars
  nnoremap <leader>t<Bar> :Tabularize /\|<CR>
  vnoremap <leader>t<Bar> :Tabularize /\|<CR>

  " Equal signs
  nnoremap <leader>t= :Tabularize /=<CR>
  vnoremap <leader>t= :Tabularize /=<CR>

  " Colons
  nnoremap <leader>t: :Tabularize /:\zs/l0l1<CR>
  vnoremap <leader>t: :Tabularize /:\zs/l0l1<CR>

  " Hashrockets
  nnoremap <leader>t> :Tabularize /=><CR>
  vnoremap <leader>t> :Tabularize /=><CR>
endif

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
" Git
"------------------------------------------------------------------------------
" Add all files
nnoremap <leader>ga :Git add -u<CR>

" View diff versus working tree
nnoremap <leader>gd :Gdiff<CR>

" Open the current file on GitHub
nnoremap <leader>gh :Gbrowse<CR>

" Push
nnoremap <leader>gp :Git push origin master<Left><Left><Left><Left><Left><Left><Left>

" Bring up status of altered files
nnoremap <leader>gs :Gstatus<CR>/\vmodified:<CR>:nohlsearch<CR><Esc>

" Write current file and add to git repository
nnoremap <leader>gw :Gwrite<CR>

" Clean submodules
nnoremap <leader>gxc :Git submodule foreach git clean -f<CR><CR>

" Add indicator for current branch in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Auto-clean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
" Quick remapping for colored column
nnoremap <leader>c :set colorcolumn=0<Left>

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Mini Buffer Explorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Map MacVim keybindings for changing tabs to same as Chrome
let macvim_skip_cmd_opt_movement = 1
nnoremap <M-D-Right> :tabnext<CR>
nnoremap <M-D-Left> :tabprevious<CR>

" Spellcheck
nnoremap <leader>sc :! aspell -c %<CR>

" Update configuration from GitHub repo
nnoremap <leader>u :!cd ~/.vim && git pull origin master && git submodule foreach git pull origin master<CR>
