# vim-php-cs-fixer

在 Vim 编辑器上集成 PHP CS Fixer

支持在目录或文件上执行 PHP CS Fixer 命令

> **Note:** 插件使用 `vim9script` 脚本语言实现，需要 `vim9.0` 以上版本

## 示例

在 `.vimrc` 上你可以这样配置：

```vim
vim9script
# php-cs-fixer 文件路径(必须)
# 官网下载: https://cs.symfony.com/
g:phpCsFixerPath = expand('~/php/php-cs-fixer-v3.phar')

# 应用规则，内容跟 PHP CS Fixer 的 --rules 选项保持一致
# 常见规则组 @PSR2,@PSR12,@PER-CS,@Symfony,@PhpCsFixer
# 默认: '@PSR12'
g:phpCsFixerRules = '@PhpCsFixer'

# php解释器路径(默认: 'php')
# php解释器所在目录加入环境变量后，无需设置此项
# g:phpCsFixerPhpPath = expand('~/php')

# --dry-run 选项(默认: false)
# g:phpCsFixerIsDryRun = true

# --verbose 选项(默认: false)
# g:phpCsFixerIsVerbose = true

# PHP_CS_FIXER_IGNORE_ENV 是否启用环境忽略
# 在不兼容的php版本或缺少扩展的情况下，请启用
# g:phpCsFixerIgnoreEnv = true

# 重新映射
nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
```

## 一、 选项

1. PHP Path

    - 说明: PHP 解释器路径
    - 默认值: `'php'`
    - 示例: `g:phpCsFixerPhpPath = '/usr/local/bin/php'`

2. php-cs-fixer 路径

    - 说明: 必须
    - 默认值: `''`
    - 示例: `g:phpCsFixerPath = 'expadn(~/php-cs-fixer.phar')`

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

6. PHP_CS_FIXER_IGNORE_ENV

    - 说明: 在不兼容的 php 版本或缺少扩展的情况下，如果不启用，php-cs-fixer 将无法工作
    - 默认值: `false`
    - 示例: `g:phpCsFixerIgnoreEnv = true`

## 二、全局函数

1. 单文件修复函数: `g:PhpCsFixerFixFile()`
2. 目录修复函数: `g:PhpCsFixerFixDir()`

## 三. 映射

1.  单文件修复映射

    -   按键绑定: `<leader>pcf`
    -   说明: 修复当前缓冲区文件，`filetype` 必须是 php

    > 假如 `phpCsFixerFixCacheDir` 设置路径异常，单文件修复会失败

2.  目录修复映射

    -   按键绑定: `<leader>pcd`
    -   说明: 修复当前缓冲区文件所在的目录或标签目录（php 类型文件）

3.  重新映射

    这是一个简单的重新映射示例：

    ```vim
    nnoremap <unique><silent><Leader>f <Plug>PhpCsFixerFixFile;
    nnoremap <unique><silent><Leader>d <Plug>PhpCsFixerFixDir;
    ```

    > 更好的映射，如果你有多个代码格式化工具，可以参考下面这种方式：

    ```vim
    vim9script
    def g:RunCodeFormat()
        # prettier 支持的文件类型有很多，这里你可以自行增减文件类型
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

## 安装

<details>
<summary>Vim 8+ packages</summary>

如果您使用的是 Vim 版本 8 或更高版本，您可以使用其内置的包管理;请参阅 `:help packages` 以获取更多信息。在你的终端上运行这些命令：

```bash
git clone https://github.com/linjialiang/vim-php-cs-fixer.git <vimfilesPath>/pack/store/start/vim-php-cs-fixer
vim -u NONE -c "helptags <vimfilesPath>/pack/store/start/vim-php-cs-fixer/doc" -c q
```

</details>

## 项目地址：

-   GitHub: https://github.com/linjialiang/vim-php-cs-fixer.git
-   Gitee: https://gitee.com/linjialiang/vim-php-cs-fixer
