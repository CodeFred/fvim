" Fred Mameri
" Updated 08/12/2014


" A little housekeeping...
:let s:this_file = expand('<sfile>')
:let s:this_path = expand('<sfile>:p:h')
:let g:fvim_path = simplify(s:this_path.'/../')
:let g:fvim_undo = g:fvim_path.'.undo'
:let g:fvim_temp = g:fvim_path.'.temp'

" Add fvim to the runtimepath, so things in it can be picked up
exec 'set runtimepath+='.g:fvim_path

" Allows vim to manage buffers effectively by paging them to disk
set hidden

" As far as I can tell, everyone does this
" Make 'a jump to the line and column marked with ma
" and `a jump to the line
nnoremap ' `
nnoremap ` '

" Personal leader key
let mapleader = ","

" 20 lines is far too few
set history=9999

" Fast saving
nmap <leader>w :w<CR>

" Enable matching breackets highlighting
" Set blinking time to 2/10 of a second
" Make the % key match not only '{' to '}', but also others
" Like an 'if' and its "else'
set showmatch
set mat=2
runtime macros/matchit.vim

" Let me choose file on the completion menu (bash style, not
" cmd.exe style)
" Also complete up to the point of ambiguity
set wildmenu
set wildmode=list:longest,full
set wildignore=.git/*,.hg/*,.svc/*,.DS_Store

" /-searches will be case sensitive only if there are capital
" letters in the search expression
" *-searches are still case sensitive
set ignorecase
set smartcase

" Set the terminal title (if running from the console)
set title

" Tell me where I am, please
set ruler

" Enable line numbers on the left side
set number
nmap <C-N><C-N> :set invnumber<CR>
nmap <C-N><C-R> :set invrelativenumber<CR>

" Intuitive backspacing
set backspace=indent,eol,start

" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
syntax on
filetype on
filetype plugin on
filetype indent on

" Highlight search terms, dynamically as they are typed
" If it gets annoying, disable it temporarily
set hlsearch
set incsearch
nmap <silent> <leader>n :silent :nohlsearch<CR>

" Show whitespace when requested
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Use confirm instead of aborting an action
set confirm

" Current directory is always matching the content of the
" active window
set autochdir

" Remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

" Use console dialogs instead of popup
" dialogs for simple choices
set guioptions+=c

" Auto-read when a file is changed externally
" REVIEW: do we want this?
set autoread

" For regular expressions, turn magic on
set magic

" Don't redraw while executing macros (performance)
set lazyredraw

" Color schemes
colorscheme desert
set background=dark

" Fonts
set antialias
set gfn=Meslo\ LG\ S\ for\ Powerline:h12,Menlo\ Regular:h12,Bitstream\ Vera\ Sans\ Mono:h11,Monospace\ 11

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set display encoding to UTF-8
" Also, write the file as UTF-8, no BOM
set encoding=utf8
set fileencoding=utf8
"set bomb

" Always show the status line
set laststatus=2

" Show the file encoding and the BOM in the status line
" (plus everything else that is displayed usually)
" (useful if vim-airline is disabled)
" if has("statusline")
" set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
" endif

" Use UNIX as the standard file type
set ffs=unix,dos,mac

" Realistically, in the age of git, who needs those pesky
" backup files anyway?
set nobackup
set nowb
set noswapfile

" Not quite wrapping it up yet...
" Do not wrap lines (I never understood why people liked that)
" But if they are ever wrapped, add an extra margin to the left
set foldcolumn=1
set nowrap

" Expand tabs and be smart about them
" 1 tab = 4 spaces
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Break the line on 80 characters
set lbr
set tw=80

" Indentation (automatic and smart)
set ai
set si

" Search selection in visual mode
func! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunc

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Map <space> to / (search) and
" Ctrl + <space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Opens a new view with the current buffer's path
" Super useful when editing files in the same directory
map <leader>bp :vsplit<CR><c-W>l :lcd %:p:h<CR>:edit .<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR> :pwd<CR>
map <leader>lcd :lcd %:p:h<CR> :pwd<CR>

" Return to last edit position when opening files
" Midnight Commander does this
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save
" Useful mostly for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Spell checking
map <leader>ss :setlocal spell!<CR>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<CR>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>

" Fast editing and reloading of vimrc configs
exec 'map <leader>e :e! '.s:this_file.'<CR>'
autocmd! BufWritePost *.vim source %

" Turn persistent undo on
" Can undo even when you close a buffer/VIM
try
    exec 'set undodir='.g:fvim_undo
    set undofile
catch
endtry

" In command mode
" Bash-like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Parenthesis/bracket
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

" Omni complete functions
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Try to source the additional config files
exec 'source '.s:this_path.'/filetypes.vim'
exec 'source '.s:this_path.'/plugins_config.vim'
