call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
source $VIMRUNTIME/mswin.vim

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to autoread when file is changed from outside
set autoread

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
" Set leader to comma (instead of backslash)
let mapleader = ","

" Fast editing and updating of .vimrc
nmap <leader>e :e! ~/.vimrc
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
set mat=2                    " How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
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
  set fileencodings=ucs-bom,utf-8,latin1
  set ambiwidth=double
endif

"------------------------------------------------------------------------------
" Colors and fonts
"------------------------------------------------------------------------------
syntax enable
set t_Co=256
colorscheme molokai
map <silent><F2> :PREVCOLOR<CR>
map <silent><F3> :NEXTCOLOR<CR>
if has("win32")
  set guifont=Consolas:h10:cANSI
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
    au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  endif
endif

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
nmap <F7> :NERDTreeToggle \| :silent NERDTreeMirror<CR>

"------------------------------------------------------------------------------
" ctags
"------------------------------------------------------------------------------
" set tags=tags;/              " Work up to root until tags directory is found

" Mappings
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
set colorcolumn=80
