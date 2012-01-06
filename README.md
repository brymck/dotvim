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

#### [Tim Pope](http://www.vim.org/account/profile.php?user_id=9012)

* [endwise](http://www.vim.org/scripts/script.php?script_id=2386) - Wisely add
* [fugitive](http://www.vim.org/scripts/script.php?script_id=2975) - A Git
  wrapper so awesome, it should be illegal
* [haml](http://www.vim.org/scripts/script.php?script_id=1433) - Haml and Sass
  syntax, indenting, and ftplugin
* [pathogen](http://www.vim.org/scripts/script.php?script_id=2332) - Easy
  manipulation of 'runtimepath', 'path', 'tags', etc
* [rails](http://www.vim.org/scripts/script.php?script_id=1567) - Ruby on
  Rails: easy file navigation, enhanced syntax highlighting, and more
* [surround](http://www.vim.org/scripts/script.php?script_id=1697) -
  Delete/change/add parentheses/quotes/XML-tags/much more with ease
* [unimpaired](http://www.vim.org/scripts/script.php?script_id=1590) - Pairs of
  handy bracket mappings

#### [Marty Grenfell](http://www.vim.org/account/profile.php?user_id=7006)

* [The NERD Commenter](http://www.vim.org/scripts/script.php?script_id=1218) -
  A plugin that allows for easy commenting of code for many filetypes.
* [The NERD tree](http://www.vim.org/scripts/script.php?script_id=1658) - A
  tree explorer plugin for navigating the filesystem

#### Others

* [coffee-script](https://github.com/kchmck/vim-coffee-script)
* [Color-Sampler-Pack](https://github.com/vim-scripts/Color-Sampler-Pack)
* [Command-T](https://github.com/wincent/Command-T)
* [csapprox](https://github.com/godlygeek/csapprox)
* [indent-object](https://github.com/michaeljsmith/vim-indent-object)
* [Javascript-Indent](https://github.com/vim-scripts/JavaScript-Indent)
* [latex](https://github.com/mineiro/vim-latex)
* [snipmate](https://github.com/msanders/snipmate.vim)
* [taglist](https://github.com/vim-scripts/taglist.vim)
* [rdoc](https://github.com/depuracao/vim-rdoc)
* [ScrollColors](https://github.com/vim-scripts/ScrollColors)
* [supertab](https://github.com/ervandew/supertab)
* [v1m](https://github.com/brymck/v1m)
* [tabular](https://github.com/godlygeek/tabular)
