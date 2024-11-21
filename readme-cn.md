# vim-php-cs-fixer

集成 PHP CS Fixer for Vim 编辑器

支持在目录或文件上执行 PHP CS Fixer 命令

> **Note:** 插件使用 `vim9script` 脚本语言实现，需要 `vim9.0` 以上版本

## 一、 选项

1. PHP Path

    - 说明: PHP 解释器路径
    - 默认值: `'php'`
    - 示例: `g:phpCsFixerPhpPath = '/usr/local/bin/php'`

2. php-cs-fixer 路径

    - 说明: 必须
    - 默认值: `''`
    - 示例: `g:phpCsFixerPath = '~/php-cs-fixer.phar'`

3. --dry-run

    - 说明: 是否启用 PHP CS Fixer 选项 `--dry-run`
    - 默认值: `false`
    - 示例: `g:phpCsFixerIsDryRun = true`

4. --verbose

    - 说明: e 是否启用 PHP CS Fixer 选项 --verbose
    - 默认值: `false`
    - 示例: `g:phpCsFixerIsVerbose = true`

5. --rules

    - 说明: settings PHP CS Fixer option --rules
    - 默认值: `'$PSR12'`
    - 示例: `g:phpCsFixerRules = '@PhpCsFixer'`

    > 常见规则组: `@PSR2`,`@PSR12`,`@PER-CS`,`@Symfony`,`@PhpCsFixer`

6. 修复缓存目录

    - 说明: 如果未指定缓存目录，则只能格式化保存的文件（需要绝对路径）
    - 默认值: `''`
    - 示例: `g:phpCsFixerFixCacheDir = $HOME .. '/.php-cs-fixer/vim-fix-cache'`

## 2. Mappings

1. 单文件修复映射

    - 按键绑定: `<leader>pcf`
    - 说明: 修复当前缓冲区文件所在的目录或标签目录（php 类型文件）

2. 目录修复映射

    - 按键绑定: `<leader>pcd`
    - 说明: 修复当前缓冲区文件，`filetype` 必须是 php，必须保存，缓冲区文件为空要想支持缓冲区修复，需要手动设置|phpCsFixerFixCacheDir|

3. 重新映射

你可以重新映射, 例如:

```vim
nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
```
