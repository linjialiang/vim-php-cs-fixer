vim9script noclear
# PHP 标准代码修复
# 维护者 地上马 <linjialiang@163.com>

var csPath: string = get(g:, 'phpCsFixerPath', '')
var phpPath: string = get(g:, 'phpCsFixerPhpPath', 'php')
var csIsVerbose: bool = get(g:, 'phpCsFixerIsVerbose', false)
var csRules: string = get(g:, 'phpCsFixerRules', '@PSR12')

export def Fix(path: string, isDryRun: bool = false, isReloadFile: bool = true): bool
  if !executable(phpPath)
    echoerr 'please configure PHP correctly.'
    return false
  endif

  if !filereadable(csPath)
    echoerr 'please set phpCsFixerPath correctly.'
    return false
  endif

  var command = $"{phpPath} {csPath} fix {path} --rules={csRules} --using-cache=no"

  if csIsVerbose
    command ..= ' --verbose'
  endif

  if isDryRun
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
  if isDryRun && statistics['fix'] > 0
    var confirmed = confirm("tested, do you want to fix?", "&yes\n&no", 2)
    if confirmed == 1
      Fix(path, false, isReloadFile)
    endif
  endif

  if !isDryRun && isReloadFile
    execute 'silent edit!'
  endif

  return statistics['state']
enddef
