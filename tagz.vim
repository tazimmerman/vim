" =============================================================================
" File:          autoload/ctrlp/tagz.vim
" Description:   buffer tags extension for ctrlp.vim
" ToDo:          error handling, corner cases, etc.
" =============================================================================

if (exists('g:loaded_ctrlp_tagz') && g:loaded_ctrlp_tagz) || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_tagz = 1

let s:tagz_var = [
	\ 'ctrlp#tagz#init()',
	\ 'ctrlp#tagz#accept',
	\ 'buffer tags',
	\ 'tags',
	\ ]

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:tagz_var)
else
	let g:ctrlp_ext_vars = [s:tagz_var]
endif

" C, C++ and Python
let s:tagz_kind_map = {
			\ "m" : "method",
			\ "v" : "variable",
			\ "c" : "class",
			\ "i" : "import",
			\ "f" : "function",
			\ "d" : "macro",
			\ "e" : "enum",
			\ "n" : "namespace",
			\ "p" : "prototype",
			\ "s" : "struct",
			\ "t" : "typedef",
			\ "u" : "union"
			\ }

" Populates the search box with items
function! ctrlp#tagz#init()
	let tagz=&tags
	let tempfile=tempname()

	try
		call system(g:ctrlp_ctags_bin . " -f " . tempfile . " --format=2 --sort=foldcase --fields=nksz --excmd=number " . bufname("#"))

		if v:shell_error
			echohl ErrorMsg
			echoerr "Could not generate tags"
			echohl None
			return []
		endif

		let &tags=tempfile
		let matches=taglist('.')
		let items=[]

		for entry in matches
			let kind=entry['kind']            " kind of tag (function, variable, etc.)
			let name=entry['name']            " name of tag
			let line=entry['line']            " line number of tag
			let class=get(entry, 'class', '') " scope of tag (class, namespace, etc.)
			let inherits=get(entry, 'inherits', '')

			let kind=get(s:tagz_kind_map, kind, kind)

			" if tag has a scope, prepend it
			if len(class) > 0
				let kind=printf("%s %s", class, kind)
			endif

			call add(items, printf("%5d:%-30s [%s]", line, name, kind))
		endfor
	finally
		let &tags=tagz
		call delete(tempfile)
	endtry

	return items
endfunction

" Called when an item has been selected
function! ctrlp#tagz#accept(mode, str)
	let nr=bufnr("#")
	let ln=str2nr(strpart(a:str,0,stridx(a:str,':')))
	call ctrlp#exit()
	call setpos('.', [nr, ln, 0, 0])
endfunction

" Assign the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Return the extension ID
function! ctrlp#tagz#id()
	return s:id
endfunction

" Uncomment this for a command that calls the new search type
" command! CtrlPTagz call ctrlp#init(ctrlp#tagz#id())
