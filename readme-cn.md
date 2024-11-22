# vim-php-cs-fixer

为 Vim 编辑器集成 PHP CS Fixer

支持在目录或文件上执行 PHP CS Fixer 命令

> **Note:** 插件使用 `vim9script` 脚本语言实现，需要 `vim9.0` 以上版本

## 示例

在 `.vimrc` 上你可以这样配置：

```vim
# php解释器路径(默认: 'php')
g:phpCsFixerPhpPath = $HOME .. '\php'

# php-cs-fixer 文件路径(必须)
# 官网下载: https://cs.symfony.com/
g:phpCsFixerPath = $HOME .. '\php-cs-fixer-v3.phar'

# --dry-run 选项(默认: false)
# g:phpCsFixerIsDryRun = true

# --verbose 选项(默认: false)
# g:phpCsFixerIsVerbose = true

# 应用规则，内容跟 PHP CS Fixer 的 --rules 选项保持一致
# 常见规则组 @PSR2,@PSR12,@PER-CS,@Symfony,@PhpCsFixer
# 默认: '@PSR12'
g:phpCsFixerRules = '@PhpCsFixer'

# 临时文件存储目录
# 警告: 未正确设置，将不能修复未保存到文件的内容
g:phpCsFixerFixCacheDir = $HOME .. '\.php-cs-fixer\vim-fix-cache'

# 重新映射
# nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
# nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
```

## 一、 选项

1. PHP Path

    - 说明: PHP 解释器路径
    - 默认值: `'php'`
    - 示例: `g:phpCsFixerPhpPath = '/usr/local/bin/php'`

2. php-cs-fixer 路径

    - 说明: 必须
    - 默认值: `''`
    - 示例: `g:phpCsFixerPath = '~/php-cs-fixer.phar'`

    > 下载 [PHP CS Fixer](https://cs.symfony.com/)

3. --dry-run

    - 说明: 是否启用 PHP CS Fixer 选项 `--dry-run`
    - 默认值: `false`
    - 示例: `g:phpCsFixerIsDryRun = true`

4. --verbose

    - 说明: 是否启用 PHP CS Fixer 选项 `--verbose`
    - 默认值: `false`
    - 示例: `g:phpCsFixerIsVerbose = true`

5. --rules

    - 说明: 设置 PHP CS Fixer 规则选项 `--rules`
    - 默认值: `'$PSR12'`
    - 示例: `g:phpCsFixerRules = '@PhpCsFixer'`

    > 常见规则组: `@PSR2`,`@PSR12`,`@PER-CS`,`@Symfony`,`@PhpCsFixer`

6. 临时文件存储目录（需要绝对路径）

    - 说明: 如果未指定 `phpCsFixerFixCacheDir`，则只能格式化已保存的内容
    - 默认值: `''`
    - 示例: `g:phpCsFixerFixCacheDir = $HOME .. '/.php-cs-fixer/vim-fix-cache'`

    > 强烈建议：正确设置 `phpCsFixerFixCacheDir`

## 二. 映射

1. 单文件修复映射

    - 按键绑定: `<leader>pcf`
    - 说明: 修复当前缓冲区文件所在的目录或标签目录（php 类型文件）

2. 目录修复映射

    - 按键绑定: `<leader>pcd`
    - 说明: 修复当前缓冲区文件，`filetype` 必须是 php

    > 假如未正确设置 `phpCsFixerFixCacheDir` ，缓冲区未保存内容将无法参与修复，并且会被丢弃。

3. 重新映射

    你可以重新映射, 例如:

    ```vim
    nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
    nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
    ```
