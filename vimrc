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

" Enable filetype plugin
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
set autoindent
set expandtab
set smartindent
set smarttab
set tabstop=2
set shiftwidth=2
set showmatch

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

" Go to previous/next line with same indentation level
nnoremap <M-,> k:call search('^'. matchstr(getline(line('.')+1), '\(\s*\)') .'\S', 'b')<CR>^
nnoremap <M-.> :call search('^'. matchstr(getline(line('.')), '\(\s*\)') .'\S')<CR>^

"------------------------------------------------------------------------------
" Unicode
"------------------------------------------------------------------------------
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,sjis,latin1
  set ambiwidth=double
endif

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
set nobackup
set nowb
set noswapfile

"------------------------------------------------------------------------------
" Terminal cursor
"------------------------------------------------------------------------------
if has("autocmd")
  if has("unix")
    let s:uname = system("echo -n \"$(uname)\"")
    if !v:shell_error && s:uname == "Linux"
      au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
      au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
      au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    endif
  endif
endif

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
map <Leader>, :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" ctags
"------------------------------------------------------------------------------
" set tags=tags;/              " Work up to root until tags directory is found

" Mappings
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"------------------------------------------------------------------------------
" Regular expressions
"------------------------------------------------------------------------------
" Default searches to very magic (special characters don't need escaping)
nnoremap / /\v
nnoremap ? ?\v
nnoremap <leader>/ :%s/\v

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

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
