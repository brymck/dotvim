My Vim Preferences
==================

Installation
------------

### Linux / Mac OS X / Cygwin

Copy and paste this into a terminal:

    cd ~
    rm -rf .vim
    git clone http://github.com/brymck/dotvim.git .vim
    rm .vimrc
    ln -s .vim/vimrc .vimrc
    cd .vim
    git submodule init
    git submodule update
    mkdir autoload
    cd autoload
    ln -s ../pathogen/autoload/pathogen.vim pathogen.vim

#### Explanation

The above commands remove any preexisting personal Vim configuration, so backup
anything you might wish to preserve going forward. This repo is then cloned
into `~/.vim`, and a symbolic link is created between `~/.vimrc` and
`~/.vim/vimrc`, which allows you to update the repo and have the changes
reflected instantly in Vim. Once the repo is cloned, all of the submodules --
links to Vim plugins -- are initialized and updated. A symbolic link is created
for [pathogen](http://www.vim.org/scripts/script.php?script_id=2332), which can
then load all of the plugins found in `~/.vim/bundle`.

The reason for all the symbolic links and git submodules is simple: from now
on, you only have to update this repo and its submodules to have all changes
reflected in Vim. And you can do this _within Vim_ by typing `,u`!

### Windows

Note: This requires Vista or a more recent version of Windows (for `mklink`),
and you must open the command prompt as an administrator (right-click > Run as
administrator...). Also, some `git` commands in Windows have a nasty habit of
causing the command prompt to "eat" subsequent pasted commands, so this needs
to be run in three parts.

First run

    cd "%UserProfile%"
    rmdir vimfiles /S /Q
    git clone http://github.com/brymck/dotvim.git vimfiles
    del _vimrc
    mklink _vimrc vimfiles\vimrc
    cd vimfiles
    git submodule init

then

    git submodule update

then
    
    mkdir autoload
    cd autoload
    mklink pathogen.vim ..\pathogen\autoload\pathogen.vim

Updating
--------

Within Vim, just type `,u`

Easy enough, yes?

Plugins
-------

This configuration utilizes the following plugins:

* [pathogen](https://github.com/tpope/vim-pathogen.git)
* [coffee_script](https://github.com/kchmck/vim-coffee-script.git)
* [color_sampler_pack](https://github.com/vim-scripts/Color-Sampler-Pack.git)
* [command_t](https://github.com/wincent/Command-T.git)
* [csapprox](https://github.com/godlygeek/csapprox.git)
* [endwise](https://github.com/tpope/vim-endwise.git)
* [fugitive](https://github.com/tpope/vim-fugitive.git)
* [haml](https://github.com/tpope/vim-haml.git)
* [indent_object](https://github.com/michaeljsmith/vim-indent-object.git)
* [javascript_indent](https://github.com/vim-scripts/JavaScript-Indent.git)
* [latex](https://github.com/mineiro/vim-latex.git)
* [nerdcommenter](httpsps://github.com/scrooloose/nerdcommenter.git)
* [nerdtree](https://github.com/scrooloose/nerdtree.git)
* [rails](https://github.com/tpope/vim-rails.git)
* [snipmate](https://github.com/msanders/snipmate.vim.git)
* [taglist](https://github.com/vim-scripts/taglist.vim.git)
* [rdoc](https://github.com/depuracao/vim-rdoc.git.git)
* [scroll_colors](https://github.com/vim-scripts/ScrollColors.git)
* [supertab](https://github.com/ervandew/supertab.git)
* [surround](httpsps://github.com/tpope/vim-surround.git)
* [unimpaired](https://github.com/tpope/vim-unimpaired.git)
* [v1m](https://github.com/brymck/v1m.git)
* [tabular](https://github.com/godlygeek/tabular.git)
