##说明
vim dotfiles根据Ryan Bates的配置为基础为修改的。主要时加入了一些vimrc文件中到注释及每次修改时间到记录，加入了bundle包管理器，插件到安装方便多了。


## 安装

```terminal
git clone git://github.com/tdoly/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install
```

## 特性

使用Bundle安装到包

```vim

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'ervandew/supertab'
Bundle 'sontek/minibufexpl.vim'
Bundle 'wincent/Command-T'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'alfredodeza/pytest.vim'
Bundle 'reinh/vim-makegreen'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'sontek/rope-vim'
```

使用Bundle安装包，只需要在github上找到插件的名字，如<https://github.com/gmarik/vundle>，然后将Bundle 'gmarik/vundle'加入到vimrc文件中，运行BundleInstall便会自动安装

snipmate单独列出
snipmate.vim

## 配置及注解

详细配置见[vimrc](/vimrc)

## 卸载

移除dotfile配置，运行下面的命令。（dotfile的配置使用link实现的）然后删除自己存放的dotfile文件即可。

```
unlink ~/.bin
unlink ~/.gitignore
unlink ~/.gemrc
unlink ~/.gvimrc
unlink ~/.irbrc
unlink ~/.vim
unlink ~/.vimrc
rm ~/.zshrc # careful here
rm ~/.gitconfig
rm -rf ~/.dotfiles
rm -rf ~/.oh-my-zsh
chsh -s /bin/bash # change back to Bash if you want
```
