let g:xml_syntax_folding=1                                                                                                                                                                                                                     
setlocal foldmethod=syntax
setlocal formatprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
