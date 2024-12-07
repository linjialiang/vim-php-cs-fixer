# vim-php-cs-fixer

[中文文档入口](./readme-cn.md)

Integration of PHP CS Fixer on Vim Editor

Supports PHP CS Fixer command execution on directories or files

> Note: The plug-in is implemented using `vim9script`, which requires vim9.0 or above to support the plug-in.

## example

on `.vimrc` you can configure this:

```vim
vim9script
# php-cs-fixer file path(must)
# download: https://cs.symfony.com/
g:phpCsFixerPath = expand('~/php/php-cs-fixer-v3.phar')

# apply rules, content consistent with PHP CS Fixer --rules option
# Common Rule Group: @PSR2,@PSR12,@PER-CS,@Symfony,@PhpCsFixer
# default: '@PSR12'
g:phpCsFixerRules = '@PhpCsFixer'

# php interpreter path(default: 'php')
# g:phpCsFixerPhpPath = expand('~/php')

# --dry-run option(default: false)
# g:phpCsFixerIsDryRun = true

# --verbose option(default: false)
# g:phpCsFixerIsVerbose = true

# enable environment ignore (PHP_CS_FIXER_IGNORE_ENV)
# enable in case of incompatible php versions or missing extensions
# g:phpCsFixerIgnoreEnv = true

# remap
nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
```

## 1. Options

1. PHP Path

    - Note: PHP interpreter path
    - default: `'php'`
    - example: `g:phpCsFixerPhpPath = expand('~/php')`

2. php-cs-fixer Path

    - Note: PHP CS Fixer path(must)
    - default: `''`
    - example: `g:phpCsFixerPath = expand('~/php/php-cs-fixer-v3.phar')`

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

6. PHP_CS_FIXER_IGNORE_ENV

    - Note: If not enabled in incompatible PHP versions or missing extensions, PHP CS fixer will not work
    - default: `false`
    - example: `g:phpCsFixerIgnoreEnv = true`

## 2. global function

1. single file fix function: `g:PhpCsFixerFixFile()`
2. directory fix function: `g:PhpCsFixerFixDir()`

## 3. Mappings

1.  single fix file map

    -   key bindings: `<leader>pcf`
    -   Note: fix current buffer file, filetype must be php.

2.  fix directory map

    -   key bindings: `<leader>pcd`
    -   Note: fix the directory where the current buffer file is located
        or the label directory(php type file)

3.  remap

    you can remap, for example:

    ```vim
    nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
    nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
    ```

    > Better mapping, if you have multiple code formatting tools, you can refer to this way to write

    ```vim
    vim9script
    def g:RunCodeFormat()
        # Prettier supports many file types, here you can add or delete file types
        var prettierSupportTypes = [
            'javascript',
            'typescript',
            'json',
            'markdown',
            'css',
            'html'
        ]
        var currentFiletype = &filetype
        if currentFiletype == 'php'
            execute 'call PhpCsFixerFixFile()'
        elseif prettierSupportTypes->index(currentFiletype) != -1
            execute 'Prettier'
        endif
    enddef

    nnoremap <silent><Leader>f :call g:RunCodeFormat()<CR>
    ```

## Install

<details>
<summary>Vim 8+ packages</summary>

If you are using Vim version 8 or higher you can use its built-in package management; see `:help packages` for more information. Just run these commands in your terminal:

```bash
git clone https://github.com/linjialiang/vim-php-cs-fixer.git <vimfilesPath>/pack/store/start/vim-php-cs-fixer
vim -u NONE -c "helptags <vimfilesPath>/pack/store/start/vim-php-cs-fixer/doc" -c q
```

</details>

## source address：

-   GitHub: https://github.com/linjialiang/vim-php-cs-fixer.git
-   Gitee: https://gitee.com/linjialiang/vim-php-cs-fixer
