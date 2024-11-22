vim9script noclear
# PHP 标准代码修复
# 维护者 地上马 <linjialiang@163.com>

if exists('g:loaded_phpCsFixer')
  finish
endif
g:loaded_phpCsFixer = true

import autoload '../lib/php_cs_fixer.vim' as that

var isDryRun: bool = get(g:, 'phpCsFixerIsDryRun', false)
var csFixCacheDir: string = get(g:, 'phpCsFixerFixCacheDir', '')

def FixDir(): void
  var dirPath: string
  # 当前缓冲区是否打开了文件
  var isOpenFile: bool = !empty(bufname('%'))
  if isOpenFile
    # 返回当前缓冲区文件所在目录
    dirPath = expand('%:p:h')
  else
    # 返回当前标签页的工作目录
    dirPath = getcwd(-1, 0)
  endif
  echohl Title | echo $"fix dir: {dirPath}"
  var confirmed: number = confirm('data cannot be recovered. confirm fix?', "&yes\n&no", 2)
  if confirmed == 1
    that.Fix(dirPath, isDryRun, isOpenFile)
  endif
enddef

def FixFile()
  if csFixCacheDir == ''
    execute 'silent write'
    that.Fix(expand('%:p'), isDryRun)
  else
    # 检测文件类型是否为php
    if &filetype != 'php'
      echohl Title | echo 'filetype must be php'
    endif
    # 先将缓冲区内容保存至其他文件
    var fixFilePath = csFixCacheDir .. '/' .. strftime('%Y%m%d%H%M%S') .. rand() .. '.php'
    execute $"silent write {fixFilePath}"
    var result = that.Fix(fixFilePath, isDryRun, false)
    if result
      # 清空缓冲区
      execute 'silent :%d'
      # 载入修复后的缓存文件
      execute $"silent :0read {fixFilePath}"
    endif
    delete(fixFilePath)
  endif
enddef

if !hasmapto('<Plug>PhpCsFixerFixFile;')
  nnoremap <unique><silent><Leader>pcf <Plug>PhpCsFixerFixFile;
endif
nnoremap <unique><script><Plug>PhpCsFixerFixFile; <SID>FixFile
nnoremap <SID>FixFile :call <SID>FixFile()<CR>

if !hasmapto('<Plug>PhpCsFixerFixDir;')
  nnoremap <unique><silent><Leader>pcd <Plug>PhpCsFixerFixDir;
endif
nnoremap <unique><script><Plug>PhpCsFixerFixDir; <SID>FixDir
nnoremap <SID>FixDir :call <SID>FixDir()<CR>
