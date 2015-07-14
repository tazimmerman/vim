setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab
setlocal textwidth=79
setlocal colorcolumn=+1,+21
setlocal keywordprg=pydoc
"setlocal errorformat=%E%f:%l:%c:\ %t%n\ %m,%E%f:%l:%c:\ %m,%E%f:%l:\ %m
"setlocal makeprg=pep8\ %

let python_highlight_all=1
let python_version_2=1

" Wrap a Visual selection in a try/catch/pdb block.
"
"   V stops Visual mode
"   '< goes to the beginning of the selection
"   O inserts a line above the selection
"   <Esc> stops Insert mode
"   '> goes to the end of the selection
"   o inserts a line below the selection
"   <Esc> stops Insert mode
"   gv> re-selects and indent the lines
vnoremap <silent> <leader>b V'<Otry:<Esc>'>oexcept:<CR>import pdb<CR>pdb.set_trace()<Esc>gv>
