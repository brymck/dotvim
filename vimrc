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

" Use par for paragraph formatting
if executable("par")
  set formatprg=par\ -w80
end

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
let mapleader=","              " Set leader to comma

" Fast editing and updating of .vimrc
execute "nnoremap <leader>v :e! " . vimfiles_path . "vimrc<CR>"
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
" Folding
"------------------------------------------------------------------------------
function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction

set foldenable                      " Enable folding
au BufWinLeave *.* mkview!          " Save last view
au BufWinEnter *.* silent loadview  " Reload last view
set foldmethod=syntax               " Base folding on syntax
set foldlevel=5                     " Default to folding five levels
set foldtext=CustomFoldText()       " More legible text for folded code

" Map folding levels
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>

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
" Eijiro
"------------------------------------------------------------------------------
function! LookupInEijiro(visual)
  if a:visual
    let a_save = @a
    normal! gv"ay
    let match = '"' . @a . '"'
    let @a = a_save
  else
    let match = expand("<cword>")
  end

  tabnew ~/.konjac/eijiro.konjac

  " Clear selection
  normal! ggdG

  " URL encoding
  let match = substitute(match, '\s', '+', 'g')
  let match = substitute(match, '%', '%%', 'g')
  let match = substitute(match, '"', '%22', 'g')

  let result = system('curl -s "http://eow.alc.co.jp/' . match . '/UTF-8/?ref=sa" | grep -E "searchwordfont" -A 1 | sed -e "s/\(.*\)searchwordfont/> \1/g" -e "s/<[^>][^>]*>//g" -e "/^[\s-]*$/d"')
  let result_lines = split(result, "[\r\n]\\{1,2\\}")
  call append("$", result_lines)
  normal! ggdd

endfunction

nnoremap <leader>k :call LookupInEijiro(0)<CR>
vnoremap <leader>k :call LookupInEijiro(1)<CR>

"------------------------------------------------------------------------------
" konjac
"------------------------------------------------------------------------------
" Quick editing of dictionaries
nnoremap <leader>d :e! ~/.konjac/dict.yml<Left><Left><Left><Left>

" Quick translation
nnoremap <leader>ze :!konjac translate % -y -f ja -t en -u 
nnoremap <leader>zj :!konjac translate % -y -f en -t ja -u 

function! SaveKonjac(from_lang, to_lang, visual, word, single, curpos)
  let original    = getline(1)[1:]
  let orig_esc    = substitute(substitute(original, '\', '\\\\', 'g'), '"', '\\"', 'g')
  let translation = getline(2)[1:]
  let trans_esc   = substitute(substitute(translation, '\', '\\\\', 'g'), '"', '\\"', 'g')

  " Leave if no translation has been provided
  if translation == ""
    echo "No translation provided, so no changes were made to dictionary."
    normal! q!
    return
  endif

  " Add translation to dictionary
  silent execute "normal! :!konjac add -f " . a:from_lang . " -t " . a:to_lang . " -o '" . orig_esc . "' -r '" . trans_esc . "'\<CR>"

  " Close current buffer
  normal! q!

  if a:single
    if a:visual
      " Go to and delete the last visual selection
      normal! gvx
    else
      " Set the previous cursor position and delete the inner word
      call setpos(".", a:curpos)
      normal! diw
    endif

    " Save the cursor position and contents of register a, paste the new word,
    " then restore the position and register contents
    let curpos = getpos(".")
    let a_save = @a
    let @a = translation
    normal! "aP
    let @a = a_save
    call setpos(".", curpos)
  else
    " Replace the entire document
    execute ':' . (a:word ? '%' : '') . 's/\V\^+\.\*\zs' . original . '/' . translation . '/gc'

    " Return to previous position in document
    execute "normal! \<C-O>"
  endif
endfunction

function! OpenKonjac(from_lang, to_lang, visual, word, single)
  " Get cursor position
  let curpos = getpos(".")

  if a:visual
    " Save register a, yank visual selection into register a, store those in a
    " variable, restore register a
    let a_save = @a
    normal! gv"ay
    let match = @a
    let @a = a_save
  else
    let match = a:word ? expand("<cword>") : getline(".")
  endif

  " Get results from konjac
  let result = system("konjac suggest \"" . match . "\" -f " . a:from_lang . " -t " . a:to_lang)
  let result_lines = split(result, "[\r\n]\\{1,2\\}")
  let result_lines_len = len(result_lines)

  " Open split above text selection
  execute "above " . (result_lines_len + 2) . "sp ~/.konjac/vim_temp.diff"

  " Clear file
  normal! ggdG

  " Write results of konjac suggest
  call setline(1, "-" . match)
  call append("$", "+")
  call append("$", result_lines)
  normal! 2G
  if result_lines_len > 0
    call setline(2, substitute(result_lines[0], '^\d\+: \(.*\) (\d\+%)$', '+\1', ''))
    normal! l
  endif

  " Define arguments
  let args = '"' . a:from_lang . '","' . a:to_lang . '",' . a:visual . ',' . a:word . ',' . a:single . ',' . string(curpos)

  " Create buffer-specific remappings
  execute "nnoremap \<buffer> \<C-w> :call SaveKonjac(" . args . ")\<CR>"
  execute "inoremap \<buffer> \<C-w> \<Esc>:call SaveKonjac(" . args . ")\<CR>"
  execute "nnoremap \<buffer> \<C-q> :q<CR>"
  execute "inoremap \<buffer> \<C-q> \<Esc>:q<CR>"
endfunction

" Translate a single word or phrase
nnoremap <leader>se :call OpenKonjac("ja", "en", 0, 1, 1)<CR>
vnoremap <leader>se :call OpenKonjac("ja", "en", 1, 1, 1)<CR>
nnoremap <leader>sj :call OpenKonjac("en", "ja", 0, 1, 1)<CR>
vnoremap <leader>sj :call OpenKonjac("en", "ja", 1, 1, 1)<CR>

" Translate a line
nnoremap <leader>E :call OpenKonjac("ja", "en", 0, 0, 1)<CR>
nnoremap <leader>E :call OpenKonjac("en", "ja", 0, 0, 1)<CR>

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

" Spellcheck
nnoremap <leader>sc :! aspell -c %<CR>

" Update configuration from GitHub repo
execute "nnoremap <leader>u :!cd " . vimfiles_path . " && git pull origin master && git submodule foreach git pull origin master<CR>"

" Add new plugin
execute "nnoremap <leader>x :!cd " . vimfiles_path . " && git submodule add git://github.com/"
execute "nnoremap <leader>xu :!cd " . vimfiles_path . " && git submodule init && git submodule update<CR><CR>"
