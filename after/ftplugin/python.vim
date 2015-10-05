setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab
setlocal textwidth=79
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
"   gv> re-selects lines and indents them
"
" Note this functionality relies on the language indent behavior, so it may not
" always work as expected. For example, if a selection contains a single line
" starting with 'return' (as you would find at the end of a function) the
" 'except' clause will be missing one indent level.
vnoremap <silent> <C-B> V'<Otry:<Esc>'>oexcept:<CR>import pdb<CR>pdb.set_trace()<Esc>gv>
inoremap <silent> <C-B> import pdb<CR>pdb.set_trace()
