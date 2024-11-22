# vim-php-cs-fixer

[中文文档入口](./readme-cn.md)

integrated PHP CS Fixer for VIM editor

Supports PHP CS Fixer command execution on directories or files

> Note: The plug-in is implemented using `vim9script`, which requires vim9.0 or above to support the plug-in.

## example

on `.vimrc` you can configure this:

```vim
# php interpreter path(default: 'php')
g:phpCsFixerPhpPath = $HOME .. '\php'

# php-cs-fixer file path(must)
# download: https://cs.symfony.com/
g:phpCsFixerPath = $HOME .. '\php-cs-fixer-v3.phar'

# --dry-run option(default: false)
# g:phpCsFixerIsDryRun = true

# --verbose option(default: false)
# g:phpCsFixerIsVerbose = true

# apply rules, content consistent with PHP CS Fixer --rules option
# Common Rule Group: @PSR2,@PSR12,@PER-CS,@Symfony,@PhpCsFixer
# default: '@PSR12'
g:phpCsFixerRules = '@PhpCsFixer'

# temporary file storage directory while repairing
# Warning: if not set correctly, you will not be able to repair content that is not saved to a file
g:phpCsFixerFixCacheDir = $HOME .. '\.php-cs-fixer\vim-fix-cache'

# remap
# nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
# nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
```

## 1. Options

1. PHP Path

    - Note: PHP interpreter path
    - default: `'php'`
    - example: `g:phpCsFixerPhpPath = '/usr/local/bin/php'`

2. php-cs-fixer Path

    - Note: PHP CS Fixer path(must)
    - default: `''`
    - example: `g:phpCsFixerPath = '~/php-cs-fixer.phar'`

    > Download [PHP CS Fixer](https://cs.symfony.com/)

3. --dry-run

    - Note: enable PHP CS Fixer option --dry-run
    - default: `false`
    - example: `g:phpCsFixerIsDryRun = true`

4. --verbose

    - Note: enable PHP CS Fixer option --verbose
    - default: `false`
    - example: `g:phpCsFixerIsVerbose = true`

5. --rules

    - Note: settings PHP CS Fixer option --rules
    - default: `'$PSR12'`
    - example: `g:phpCsFixerRules = '@PhpCsFixer'`

    > Common Rule Group: `@PSR2`,`@PSR12`,`@PER-CS`,`@Symfony`,`@PhpCsFixer`

6. temporary file storage directory(absolute path required)

    - Note: if no `phpCsFixerFixCacheDir` is specified, only saved content can be formatted
    - default: `''`
    - example: `g:phpCsFixerFixCacheDir = $HOME .. '/.php-cs-fixer/vim-fix-cache'`

    > Strongly recommend: setting `phpCsFixerFixCacheDir` correctly

## 2. Mappings

1. single fix file map

    - key bindings: `<leader>pcf`
    - Note: fix the directory where the current buffer file is located
      or the label directory(php type file)

2. fix directory map

    - key bindings: `<leader>pcd`
    - Note: fix current buffer file, filetype must be php, want to support
      empty buffer fix, you need to manually set |phpCsFixerFixCacheDir|

    If `phpCsFixerFixCacheDir` is not set correctly, the unsaved contents of the buffer will not participate in the repair and will be discarded.

3. remap

    you can remap, for example:

    ```vim
    nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
    nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
    ```
