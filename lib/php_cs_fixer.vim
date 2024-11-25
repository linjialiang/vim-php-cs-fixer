vim9script noclear
# PHP 标准代码修复
# 维护者 地上马 <linjialiang@163.com>

var csPath: string = get(g:, 'phpCsFixerPath', '')
var phpPath: string = get(g:, 'phpCsFixerPhpPath', 'php')
var csIsVerbose: bool = get(g:, 'phpCsFixerIsVerbose', false)
var csRules: string = get(g:, 'phpCsFixerRules', '@PSR12')
var isDryRun: bool = get(g:, 'phpCsFixerIsDryRun', false)
var csFixCacheDir: string = get(
  g:,
  'phpCsFixerFixCacheDir',
  expand(expand('<script>:h:h') .. '/temp')
)

# 检测并创建缓存临时目录
def CheckAndCreateCacheDir(dirPath: string)
  if !isdirectory(dirPath)
    mkdir(dirPath, 'p')
  endif
enddef

# 修复函数
def Fix(path: string, isDryRunMode: bool = false, isReloadFile: bool = true): bool
  if !executable(phpPath)
    echohl Error | echo 'please configure PHP correctly.'
    return false
  endif

  if !filereadable(csPath)
    echohl Error | echo 'please set phpCsFixerPath correctly.'
    return false
  endif

  var command = $"{phpPath} {csPath} fix {path} --rules={csRules} --using-cache=no"

  if csIsVerbose
    command ..= ' --verbose'
  endif

  if isDryRunMode
    command ..= ' --dry-run'
    echohl Title | echo "[DRY RUN MODE]" | echohl None
  endif

  var output = system(command)

  var statistics = {
    'state': true,
    'fix': 0,
    'error': 0
  }

  for line in split(output, '\n')
    var errorInfo = 'Files that were not fixed due to errors reported during linting before fixing:'
    if match(line, errorInfo) != -1
      statistics['state'] = false
    endif

    if match(line, '^\s\+\d\+)') != -1
      if statistics['state']
        statistics['fix'] += 1
      else
        statistics['error'] += 1
      endif
    endif
  endfor

  if csIsVerbose
    echohl Title | echo output | echohl None
  else
    echohl Title | echo 'fix: ' .. statistics['fix'] | echohl None
    if statistics['error'] > 0
      echohl Error | echo 'error: ' .. statistics['error'] | echohl None
    endif
  endif

  # 如果没有需要修复，就不用提示是否要移除 --dry-run 执行修复
  if isDryRunMode && statistics['fix'] > 0
    var confirmed = confirm("tested, do you want to fix?", "&yes\n&no", 2)
    if confirmed == 1
      Fix(path, false, isReloadFile)
    endif
  endif

  if !isDryRunMode && isReloadFile
    execute 'silent edit!'
  endif

  return statistics['state']
enddef

# 修复目录
export def FixDir()
  # 当前缓冲区是否打开了文件
  var isOpenFile: bool = !empty(bufname('%'))
  var dirPath: string
  if isOpenFile
    # 先保存文件
    execute 'silent write'
    # 返回当前缓冲区文件所在目录
    dirPath = expand('%:p:h')
  else
    # 返回当前标签页的工作目录
    dirPath = getcwd(-1, 0)
  endif
  echohl Title | echo $"fix dir: {dirPath}"
  var confirmed: number = confirm('data cannot be recovered. confirm fix?', "&yes\n&no", 2)
  if confirmed == 1
    Fix(dirPath, isDryRun, isOpenFile)
  endif
enddef

# 修复文件
export def FixFile()
  # 检测文件类型是否为php
  if &filetype != 'php'
    echohl Error | echo 'filetype must be php'
  # elseif csFixCacheDir == ''
  #   # 先保存文件
  #   execute 'silent write'
  #   Fix(expand('%:p'), isDryRun)
  else
    CheckAndCreateCacheDir(csFixCacheDir)
    # 当前缓冲区是否打开了文件
    var isOpenFile: bool = !empty(bufname('%'))
    # 先将缓冲区内容保存至其他文件
    var fixFilePath = expand(csFixCacheDir .. '/' .. strftime('%Y%m%d%H%M%S') .. rand() .. '.php')
    # TODO 暂时无解的问题
    # 这里有个提示问题，缓冲区没有文件时，当前缓冲区打开的文件为临时文件
    # -- 后面的 delete(fixFilePath) 在删除打开文件时，窗口会报错
    execute $"silent write {fixFilePath}"
    if filereadable(fixFilePath)
      var result = Fix(fixFilePath, isDryRun, false)
      if result
        # 清空缓冲区
        execute 'silent :%d'
        # 载入修复后的缓存文件
        execute $"silent :0read {fixFilePath}"
      endif
      silent delete(fixFilePath)
    else
      echohl Error | echo 'Temporary files not visible'
    endif
  endif
enddef

