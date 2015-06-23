" Cscope {{{
if has('cscope')
    set cscopeprg=cscope
    set cscopetag
    set cscopetagorder=1
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set nocscopeverbose

    if filereadable('cscope.out')
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " Find this C symbol
    nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " Find this definition
    nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " Find functions called by this function
    nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    " Find functions calling this function
    nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " Find this text string
    nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " Find this egrep pattern
    nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    " Find this file
    nmap <C-@>f :cs find f <C-R>=expand("<cword>")<CR><CR>
    " Find files #including this file
    nmap <C-@>i :cs find i <C-R>=expand("<cword>")<CR><CR>
    " View the tag (g-] behavior)
    nmap <C-@>] :tselect <C-R>=expand("<cword>")<CR><CR>
endif
" }}}

" vim: foldmethod=marker
