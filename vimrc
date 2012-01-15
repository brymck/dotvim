"------------------------------------------------------------------------------
" Pathogen
"------------------------------------------------------------------------------
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
set nocompatible               " Turn off vi compatibility
source $VIMRUNTIME/mswin.vim   " Some basic MS keybindings
filetype plugin on             " Enable filetype plugin
filetype indent on             " Enable indent pluing

" Get cross-platform runtime and paths
if has("win32")
  let vimfiles_path="~/vimfiles/"
  let vimrc_path="~/_vimrc"
else
  let vimfiles_path="~/.vim/"
  let vimrc_path="~/.vimrc"
endif

set autoread                   " Set to autoread when file is changed
set hidden                     " Enable handling of multiple buffers
set history=1000               " Keep a longer history of commands
runtime macros/matchit.vim     " Extended % matching

set noerrorbells               " No bells for error messages
set visualbell                 " Use visual bell instead of beeping
set vb t_vb=                   " No beep or flash
set timeoutlen=500             " Wait 0.5 s for a key sequence to complete

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
let mapleader=","              " Set leader to comma

" Fast editing and updating of .vimrc
execute "nnoremap <leader>e :e! " . vimfiles_path . "vimrc<CR>"
execute "autocmd! bufwritepost vimrc source " . vimrc_path

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

set textwidth=0              " No maximum width of text for insertion
set wrapmargin=0             " Turn off automatic insertion of newlines

set nojoinspaces             " Don't add two spaces between joined sentences

" Turn off search highlighting if it gets annoying
nnoremap <leader>n :nohlsearch<CR>
nnoremap <leader>w :set wrap!<CR>

" Rehighlight text after indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Rapidly toggle invisible characters, using same symbols as TextMate
nnoremap <leader>l :set list!<CR>

"------------------------------------------------------------------------------
" Tabular
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
    let &termencoding=&encoding
  endif

  " Use UTF-8, but allow some other common encodings
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8,utf-16,sjis,latin1,ucs-bom

  set ambiwidth=double         " Make non-ASCII glyphs double-width for CJK
endif

" Remap ¥ to \ for command line
cnoremap ¥ <Bslash>

set noimd                      " Retain input method editor memory for modes

"------------------------------------------------------------------------------
" Colors and fonts
"------------------------------------------------------------------------------
syntax enable                  " Enable syntax highlighting
set t_Co=256                   " Default terminal colors to 256
colorscheme candycode          " Use candycode scheme by default

" Set default fonts for different platforms
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

" Easily switch between buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

"------------------------------------------------------------------------------
" konjac
"------------------------------------------------------------------------------
nnoremap <leader>ki :!konjac import %<CR>
nnoremap <leader>kt :!konjac translate % from 

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

" Copy current word or selection and replace for the entire document
nnoremap <leader>s yiw:%s/\<<C-r>"\>//gc<Left><Left><Left>
vnoremap <leader>s y:%s/\<<C-r>"\>//gc<Left><Left><Left>

" Count number of occurrences for the current or selected word
nnoremap <leader>m yiw:%s/\<<C-r>"\>//gn<CR><C-O>
vnoremap <leader>m y:%s/\<<C-r>"\>//gn<CR><C-O>

" Case-insensitive unless capital letter is included
set ignorecase
set smartcase

set report=0                   " Notify how many replacements were made

"------------------------------------------------------------------------------
" Fugitive
"------------------------------------------------------------------------------
" Push
nnoremap <leader>gp :Git push origin master<Left><Left><Left><Left><Left><Left><Left>

" Bring up status of altered files
nnoremap <leader>gs :Gstatus<CR>/\vmodified:/e<CR>:nohlsearch<CR><Esc>

" Write current file and add to git repository
nnoremap <leader>gw :Gwrite<CR>

" Clean submodules
nnoremap <leader>gxc :Git submodule foreach git clean -f<CR><CR>

" Add indicator for current branch in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Auto-clean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"------------------------------------------------------------------------------
" v1m
"------------------------------------------------------------------------------
nnoremap <leader>1a :call FullToHalfAll()<CR>
nnoremap <leader>1f :call FullToHalf()<CR>
nnoremap <leader>1s :call ReopenAsShiftJIS()<CR>
nnoremap <leader>1h :call HighlightTerms()<CR>

" Keybindings for AppleScripts
nnoremap <leader>1mp :call ImportTagsPowerPoint()<CR><CR>
nnoremap <leader>1mw :call ImportTagsWord()<CR><CR>
nnoremap <leader>1xp :call ExtractTagsPowerPoint()<CR><CR>
nnoremap <leader>1xw :call ExtractTagsWord()<CR><CR>

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
" Quick remapping for colored column
nnoremap <leader>c :set colorcolumn=0<Left>

" SuperTab
let g:SuperTabDefaultCompletionType="context"

" Map MacVim keybindings for changing tabs to same as Mac Terminal
let macvim_skip_cmd_opt_movement=1
nnoremap <S-D-Right> :tabnext<CR>
nnoremap <S-D-Left> :tabprevious<CR>

" Spellcheck
nnoremap <leader>sc :! aspell -c %<CR>

" Update configuration from GitHub repo
execute "nnoremap <leader>u :!cd " . vimfiles_path . " && git pull origin master && git submodule foreach git pull origin master<CR>"

" Add new plugin
execute "nnoremap <leader>x :!cd " . vimfiles_path . " && git submodule add git://github.com/"
execute "nnoremap <leader>xu :!cd " . vimfiles_path . " && git submodule init && git submodule update<CR><CR>"
