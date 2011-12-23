"
" Display pyflakes errors & warnings in a location window.
"
" Author: Tocer Deng, Marius Gedminas
" Maintainer: Troy Zimmerman
" Version: 0.6.3
" License: Released under the Vim License.
"
" Place this file in your ftplugin directory, along side the pyflakes.vim file.
"

if !has("python")
    echohl ErrorMsg | echomsg "vim must be compiled with +python" | echohl None
    finish
endif

if !exists("g:pcs_hotkey")
    let g:pcs_hotkey = "<F6>"
endif

if !exists("g:pcs_check_when_saving")
    let g:pcs_check_when_saving = 1
endif

if !exists("g:pcs_display_signs")
   let g:pcs_display_signs = 1
endif

if !exists("g:pcs_ignore_unused_modules")
   let g:pcs_ignore_unused_modules = "baseSite"
endif

function! PySyntaxChecker()
    if &buftype == "quickfix"
        py quickfix.close()
    else
        py pysyntaxchecker.check()
    endif
endfunction

exec "noremap <silent>".g:pcs_hotkey." :call PySyntaxChecker()<CR>"

augroup PyCheckSyntax
    autocmd!
    autocmd BufWritePost * py if vim.eval("&ft") == "python": pysyntaxchecker.maybecheck(vim.eval("expand('<afile>:p')"))
    autocmd BufWinLeave * py if vim.eval("&ft") == "python": quickfix.maybeclose()
augroup END

sign define PySyntaxError text=>> texthl=ErrorMsg

python << EOF

import _ast
import collections
import re
import vim

from pyflakes import checker

class VimFunction(object):
    def __getattr__(self, name):
        self.func_name = name
        return self.call

    def call(self, *args):
        _args = ",".join([repr(arg) for arg in args])
        return vim.eval("%s(%s)" % (self.func_name, _args))

vimfunc = VimFunction()

class VimSigns(object):
    def __init__(self):
        self.signs = collections.defaultdict(set)

    def place(self, **kwargs):
        vim.command("sign place %(sid)d line=%(lnum)d name=%(name)s buffer=%(nr)d" % kwargs)

    def unplace(self, **kwargs):
        vim.command("sign unplace %(sid) buffer=%(nr)" % kwargs)

    def show(self, errors):
        nr = int(vim.eval("bufnr('%')"))
        for error in errors:
            sid = len(self.signs[nr]) + 1
            self.place(sid=sid, lnum=error["lnum"], name="PySyntaxError", nr=nr)
            self.signs[nr].add(sid)

    def hide(self):
        nr = int(vim.eval("bufnr('%')"))
        for sid in self.signs[nr]:
            self.unplace(sid=sid, nr=nr)
        del self.signs[nr]

vimsigns = VimSigns()

class VimQuickFix(object):
    def __init__(self):
        if vimfunc.exists("g:pcs_win_height"):
            self.win_height = 10
        else:
            self.win_height = vim.eval("g:pcs_win_height")

    def open(self):
        self.close()
        height = len(vimfunc.getloclist(0))
        if height:
            height = min(height, self.win_height)
            vim.command("lopen %d" % height)
        else:
            self.close()

    def close(self):
        vim.command("lclose")

    def maybeclose(self):
        if vim.eval("g:pcs_check_when_saving") == "1":
            self.close()

    def make(self, msgs):
        if msgs:
            keys = ["filename", "lnum", "text", "type"]
            errors = [dict(zip(keys, msg)) for msg in msgs]
            # vimsigns.show(errors)
            vimfunc.setloclist(0, errors, "r")
            self.open()
        else:
            # vimsigns.hide()
            self.close()

quickfix = VimQuickFix()

class PySyntaxChecker(object):
    def check(self, filename=None):
        if not filename:
            filename = vim.current.buffer.name
        src = "\n".join(vim.current.buffer)
        msgs = []
        try:
            tree = compile(src, '<unknown>', 'exec', _ast.PyCF_ONLY_AST)
        except (SyntaxError, IndentationError), e:
            msgs.append((filename, e.lineno or 1, e.args[0], "E"))
        except Exception, e:
            msgs.append((filename, 1, e.args[0], "E"))
        else:
            chk = checker.Checker(tree, filename)
            chk.messages.sort(lambda a, b: cmp(a.lineno, b.lineno))
            for msg in chk.messages:
                msgs.append((filename, msg.lineno or 1, msg.message % msg.message_args, "W"))
		msgs = self.filter(msgs)
        quickfix.make(sorted(msgs))

    def filter(self, msgs):
        modules = vim.eval("g:pcs_ignore_unused_modules")
        if modules == "":
            return msgs
        else:
            pattern = re.compile("\'(" + modules + ")\' imported but unused")
            res = []
            for msg in msgs:
                if pattern.match(msg[2]) is None:
                    res.append(msg)
            return res

    def maybecheck(self, filename=None):
        if vim.eval("g:pcs_check_when_saving") == "1":
            self.check(filename)

pysyntaxchecker = PySyntaxChecker()

EOF
