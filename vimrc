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
let is_windows=has("win32")
if is_windows
  let vimfiles_path=$VIM . "/vimfiles/"
  let vimrc_path=$VIM . "/_vimrc"
  let terminal="cmd"
  let terminal_flag="/c"
else
  let vimfiles_path="~/.vim/"
  let vimrc_path="~/.vimrc"
  let terminal="bash"
  let terminal_flag="-c"
endif

set autoread                   " Set to autoread when file is changed
set hidden                     " Enable handling of multiple buffers
set history=1000               " Keep a longer history of commands
runtime macros/matchit.vim     " Extended % matching

set noerrorbells               " No bells for error messages
set visualbell                 " Use visual bell instead of beeping
set vb t_vb=                   " No beep or flash
set timeoutlen=500             " Wait 0.5 s for a key sequence to complete

set wildmode=longest:full      " Show all matches for tab-completing file names
set wildmenu                   " Turn on wild menu

" Allow jj to be used to escape from insert mode  
inoremap jj <Esc>

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
" Use par for paragraph formatting
if executable("par")
  set formatprg=par\ 80gqs0
endif

" Navigate by display lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Fuzzy search through help with FuzzyFinder
nnoremap <c-h> :FufHelp<CR>

"------------------------------------------------------------------------------
" Windows
"------------------------------------------------------------------------------
if is_windows
  " Turn off obnoxious path abbreviation in Gvim
  set guitablabel=%t

  " Set a font for double-width characters
  set guifontwide=MS\ Mincho:h10:cANSI

  " Semicolon is pretty useless, and colon requires pressing shift
  nnoremap ; :
endif

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
let mapleader=","              " Set leader to comma

" Fast editing and updating of .vimrc
execute "nnoremap <leader>v :e! " . vimfiles_path . "vimrc<CR>"
execute "autocmd! bufwritepost vimrc source " . vimrc_path

" Fast looking in gems
nnoremap <leader>g :exe "e " . escape(system("gem which "), ' ')<Left><Left><Left><Left><Left><Left><Left><Left>

"------------------------------------------------------------------------------
" Indent
"------------------------------------------------------------------------------
set autoindent               " Automatically indent
set expandtab                " Use spaces instead of tabs
set smartindent              " Smartly insert an extra level of indentation
set softtabstop=2            " Indent two spaces when pressing tab
set shiftwidth=2             " Indent two spaces
set showmatch                " Jump to match when found

set number                   " Show line number
set ruler                    " Show line and column number in lower right
set nowrap                   " Don't wrap text
set incsearch                " Search incrementally
set hlsearch                 " Highlight search results
set mat=2                    " How many tenths of a second to blink

set linebreak                " Break on word barriers
set showbreak=>>>            " Line break shown as >>>

set textwidth=100            " No maximum width of text for insertion
set wrapmargin=0             " Turn off automatic insertion of newlines

set nojoinspaces             " Don't add two spaces between joined sentences

" Turn off search highlighting if it gets annoying
nnoremap <leader>n :nohlsearch<CR>
nnoremap <leader>w :set wrap!<CR>

" Rehighlight text after indentation in visual mode
vnoremap < <gv
vnoremap > >gv

"------------------------------------------------------------------------------
" Insert mode
"------------------------------------------------------------------------------
" Ctrl+Backspace deletes previous word
inoremap <D-BS> <C-W>

" More natural keybindings in insert mode for Mac
inoremap <M-Left> <C-Left>
inoremap <M-Right> <C-Right>
inoremap <D-Left> <Home>
inoremap <D-Right> <End>

" Selecting text
inoremap <S-D-Left> <S-Home>
inoremap <S-D-Right> <S-End>
inoremap <S-M-Left> <S-C-Left>
inoremap <S-M-Right> <S-C-Right>
snoremap <S-D-Left> <S-Home>
snoremap <S-D-Right> <S-End>
snoremap <S-M-Left> <S-C-Left>
snoremap <S-M-Right> <S-C-Right>

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

  " Commas
  nnoremap <leader>t, :Tabularize /,\zs/l0l1<CR>
  vnoremap <leader>t, :Tabularize /,\zs/l0l1<CR>

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

  " Gvim struggles with ambiguous width. MacVim doesn't.
  if is_windows
    set ambiwidth=double       
  endif
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

" Quick toggle between light and dark color schemes
nnoremap <leader>d :colorscheme candycode<CR>
nnoremap <leader>l :colorscheme nekotako<CR>

" Set default fonts for different platforms
if has("win32")
  set guifont=Consolas:h10:cANSI
else
  set guifont=Menlo\ Regular:h12
endif

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " ")
endfunction
nmap <C-S-P> :call <SID>SynStack()<CR>

"------------------------------------------------------------------------------
" Files
"------------------------------------------------------------------------------
set nobackup                   " Don't create a permanent backup when writing
set nowritebackup              " Don't make a temporary backup either
set noswapfile                 " Don't use a swapfile for the buffer

" Easily switch between buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

"------------------------------------------------------------------------------
" Eijiro
"------------------------------------------------------------------------------
nnoremap <leader>k :call LookupInEijiro(0)<CR>
vnoremap <leader>k :call LookupInEijiro(1)<CR>

"------------------------------------------------------------------------------
" konjac
"------------------------------------------------------------------------------
" Get rid of untranslated diff sections
nnoremap <leader>zd :%s/\v^\@\@ \d+ \@\@\n\-(.*)\n\+\1\n//gic<CR>

" Quick translation
nnoremap <leader>ze :!konjac translate % -y -f ja -t en -u 
nnoremap <leader>zj :!konjac translate % -y -f en -t ja -u 

" Translate a single word or phrase
nnoremap <leader>se :call OpenKonjac("ja", "en", 0, 1, 1)<CR>
vnoremap <leader>se :call OpenKonjac("ja", "en", 1, 1, 1)<CR>
nnoremap <leader>sj :call OpenKonjac("en", "ja", 0, 1, 1)<CR>
vnoremap <leader>sj :call OpenKonjac("en", "ja", 1, 1, 1)<CR>

" Translate a line
nnoremap <leader>E :call OpenKonjac("ja", "en", 0, 0, 1)<CR>
nnoremap <leader>J :call OpenKonjac("en", "ja", 0, 0, 1)<CR>

" Translate word or phrase for entire document
nnoremap <leader>e :call OpenKonjac("ja", "en", 0, 1, 0)<CR>
vnoremap <leader>e :call OpenKonjac("ja", "en", 1, 1, 0)<CR>
nnoremap <leader>j :call OpenKonjac("en", "ja", 0, 1, 0)<CR>
vnoremap <leader>j :call OpenKonjac("en", "ja", 1, 1, 0)<CR>

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
map <leader>, :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" Notes
"------------------------------------------------------------------------------
" Write to Documents/Notes by default
let g:notes_directory='~/Documents/Notes'

" No smart quotes
let g:notes_smart_quotes=0

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
nnoremap <leader>; :%s/\v^\+.*\zs/g<Left><Left>

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
" Conque
"------------------------------------------------------------------------------
" Map Ctrl+W to change tabs in insert mode
let g:ConqueTerm_CWInsert = 1

" Different interactive shell environments
exe "nnoremap <leader>qb :ConqueTermSplit " . terminal . "<CR>"
exe "nnoremap <leader>qj :ConqueTermSplit " . terminal . " " . terminal_flag . " node<CR>"
exe "nnoremap <leader>qp :ConqueTermSplit " . terminal . " " . terminal_flag . " re.pl<CR>"
exe "nnoremap <leader>qr :ConqueTermSplit " . terminal . " " . terminal_flag . " irb<CR>"

" Mappings similar to SLIME
let g:ConqueTerm_SendFileKey = '<C-C><C-C>'
let g:ConqueTerm_SendVisKey = '<C-C><C-C>'

" Automatically close buffer when program exits
let g:ConqueTerm_CloseOnEnd = 1

" Regex for highlighting prompt
let g:ConqueTerm_PromptRegex = '\v^(\S+\$|\>|\S+ [0-9.p]+ \d+(\*| \>)|\s+\d\.\.)'

" Ignore start messages
let g:ConqueTerm_StartMessages = 0

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
" Fix weird mapping for applescript
autocmd BufReadPost *.applescript set filetype=applescript

" Quick remapping for colored column
nnoremap <leader>c :set colorcolumn=0<Left>

" SuperTab
let g:SuperTabDefaultCompletionType="context"

" Map MacVim keybindings for changing tabs to same as Mac Terminal
let macvim_skip_cmd_opt_movement=1
nnoremap <S-D-Right> :tabnext<CR>
nnoremap <S-D-Left> :tabprevious<CR>

" New tab shortcut for Windows
if is_windows
  nnoremap <C-T> :tabnew<CR>
endif

" Spellcheck
nnoremap <leader>sc :! aspell -c %<CR>

" Update configuration from GitHub repo
execute "nnoremap <leader>u :!cd " . vimfiles_path . " && git pull origin master && git submodule foreach git pull origin master<CR>"

" Add new plugin
execute "nnoremap <leader>x :!cd " . vimfiles_path . " && git submodule add git://github.com/"
execute "nnoremap <leader>xu :!cd " . vimfiles_path . " && git submodule init && git submodule update<CR><CR>"

" Load custom additions to vimrc
if is_windows
  if filereadable($HOME . "/_vimrc_custom")
    source $HOME/_vimrc_custom
  endif
else
  if filereadable($HOME . "/.vimrc_custom")
    source $HOME/.vimrc_custom
  endif
endif
