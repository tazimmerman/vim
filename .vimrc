set nocompatible               " Use Vim, not Vi
set tabstop=4                  " Number of spaces for tab
set shiftwidth=4               " Number of spaces for (auto)indent
set cindent                    " Automatic C-style identing
set autoindent                 " Use ident of current line when starting new lines
set smartindent                " Smart autoindentng when starting new lines
set smarttab                   " Tab inserts blanks according to 'shiftwidth'
set softtabstop=4              " NUmber of spaces used for tabs
" set expandtab                " Use spaces rather than tabs
set backspace=start,indent,eol " Allow backspace over start of insert, autoindent & link breaks
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn\*,*.pyc,*.pyo,*.so,*.o,*.dll,*.lib,*.pyd,*.obj,*.h5,*.ttf,*.pdf,*.xls,*.pcl,*.gz,*.png,*.gif,*.jpg
set complete=.,w,b,u
set completeopt=menu,preview
set ignorecase       " Ignore case when searching
set smartcase        " Retain case when pattern has uppercase
set infercase        " Adjust case for keyword completion
set showmatch        " Display matching braces
set hlsearch         " Highlight searches
set incsearch        " Incremental searches
set ruler            " Display cursor position
" set number         " Display line numbers
set nowrap           " Do not wrap text
set nowrapscan       " Do not wrap searches
set comments=sr:/*,mb:*,ex:*/
set formatoptions=cr
set makeprg=make
set fileformats=unix,dos
set encoding=utf-8
set browsedir=buffer
set switchbuf=usetab " Consider tabs when switching buffers
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winpos,winsize
set mousehide        " Hide mouse when typing
set hidden           " Don't unload buffers when abandoned
set noswapfile
set shellslash       " Always use a forward slash, not a backslash
set fillchars=       " Don't use silly characters to divide windows
set foldmethod=indent
set foldlevel=20
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=1
set t_Co=256
set winminheight=0
set winminwidth=0
set updatetime=2000
set antialias
set scrolloff=5
set listchars=tab:\|\ ,extends:>,precedes:<
set tags=./tags;/.
set runtimepath+=~/vim/vcs,~/vim/ctrlp
set cursorline       " Highlight current line

let java_comment_strings=1
let java_highlight_debug=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

let python_highlight_all=1

let g:netrw_browse_split=3
let g:netrw_browse_alto=1
let g:netrw_browse_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=".*.swp;*.o"

let g:AutoClosePairs={'(': ')', '{': '}', '[': ']', '"': '"', "'": "'"}
let g:AutoCloseProtectedRegions=["Comment", "String", "Character"]

let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_dotfiles=0
let g:ctrlp_jump_to_buffer=1
let g:ctrlp_map='<silent> <leader>p'
let g:ctrlp_max_height=20
let g:ctrlp_use_caching=1
let g:ctrlp_working_path_mode=0
let g:ctrlp_extensions=['tagz']
let g:ctrlp_ctags_bin='ctags'

let g:tagbar_ctags_bin='ctags'
let g:tagbar_compact=1
let g:tagbar_usearrows=1

let g:pcs_check_when_saving=0
let g:golden_ratio_autocommand=0
let VCSCommandSVNExec='svn'

augroup VCSCommand
	au User VCSBufferCreated setlocal bufhidden=wipe
augroup END

au BufEnter *.py :syntax sync fromstart

syntax on            " Enable syntax highlighting
filetype on          " Enable filetype detection
filetype indent on   " Enable filetype-specific indenting
filetype plugin on   " Enable filetype-specific plugins

" Recognize .C and .H extensions
au BufReadPost,BufNewFile *.C,*.H setlocal filetype=cpp
au BufReadPost,BufNewFile *.C,*.H let b:browsefilter="Headers & Sources\t*.C;*.H\nAll Files\t*\n"

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Erase any trailing spaces
nmap <silent> <Leader>trim :%s/\s\+$//g<CR>

" Tag Bar Toggle
nmap <silent> <leader>tags :TagbarToggle<CR>

" Open/Close tabs
nmap <silent> <C-Insert> :tabnew<CR>
nmap <silent> <C-Delete> :tabclose<CR>

" Navigate buffers
nmap <silent> <M-PageDown> :bnext<CR>
nmap <silent> <M-PageUp> :bprevious<CR>

" Easy copy/paste
nmap <unique> <M-p> "*p
vmap <unique> <M-y> "+y

" Popup navigation
inoremap <silent> <Up> <C-R>=pumvisible() ? "\<lt>C-P>" : "\<lt>Up>"<CR>
inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>Down>"<CR>

" Reset search pattern on ESC
nnoremap <silent> <ESC> :let @/=""<CR>

" Resize current window
nnoremap <silent> <leader>gr :GoldenRatioResize<CR>

" Abbreviations
function EatChar(p)
	let c = nr2char(getchar(0))
	return (c =~ a:p) ? '' : c
endfunction

if has("gui_running")
	set showtabline=1 " Display tabs (if they exist)
	set guioptions=ae " Own visual selections
	set guifont=Meslo\ LG\ M\ 11
	set guitablabel=%t\ %m%r
	set lines=48
	set columns=96
	set background=light
	colorscheme solarized

	" Display tag prototype in status line
	" function TagStatusLine()
	" 	let prototype = Tlist_Get_Tag_Prototype_By_Line()
	" 	let line = ''
	" 	if len(prototype) > 0
	" 		let line = '[%<' . prototype . ']'
	" 	endif
	" 	let line = line . '%=[%04l,%03v][%P]'
	" 	return line
	" endfunction

	" set statusline=%!TagStatusLine()
else
	set background=light
	colorscheme solarized
endif

command! CtrlPTagz call ctrlp#init(ctrlp#tagz#id())
nnoremap <silent> <leader>t :CtrlPTagz<CR>
nnoremap <silent> <leadeR>u :CtrlPMRU<CR>
nnoremap <silent> <leadeR>b :CtrlPBuffer<CR>

function! TryExcept() range
	" Insert try one line above selection.
	exec "normal Otry:\<Esc>"
	" Indent the last visual selection.
	exec "normal gv>\<Esc>"
	" Insert except one line below selection.
	exec "normal `>oexcept:\<CR>import pdb; pdb.set_trace()\<Esc>"
endfunction

vmap <silent> <leader>pdb :call TryExcept()<CR>
