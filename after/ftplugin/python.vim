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

iabbrev pdb import pdb<CR>pdb.set_trace()<Esc>
