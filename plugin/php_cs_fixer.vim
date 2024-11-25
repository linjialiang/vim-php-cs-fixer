vim9script noclear
# PHP 标准代码修复
# 维护者 地上马 <linjialiang@163.com>

if exists('g:loaded_phpCsFixer')
  finish
endif
g:loaded_phpCsFixer = true

import autoload '../lib/php_cs_fixer.vim' as that

def FixDir()
  that.FixDir()
enddef

def FixFile()
  that.FixFile()
enddef

# if !hasmapto('<Plug>PhpCsFixerFixFile;')
  # nnoremap <unique><silent><Leader>pcf <Plug>PhpCsFixerFixFile;
# endif
nnoremap <unique><script><Plug>PhpCsFixerFixFile; <SID>FixFile
nnoremap <SID>FixFile :call <SID>FixFile()<CR>

# if !hasmapto('<Plug>PhpCsFixerFixDir;')
  # nnoremap <unique><silent><Leader>pcd <Plug>PhpCsFixerFixDir;
# endif
nnoremap <unique><script><Plug>PhpCsFixerFixDir; <SID>FixDir
nnoremap <SID>FixDir :call <SID>FixDir()<CR>
