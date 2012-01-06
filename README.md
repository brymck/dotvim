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

The above commands remove any preexisting personal vim configuration, so backup anything
you might wish to preserve going forward. This repo is then cloned into `~/.vim`, and
a symbolic link is created between `~/.vimrc` and `~/.vim/vimrc`, which allows you to
update the repo and have the changes reflected instantly in Vim. Once the repo is cloned,
all of the submodules -- links to Vim plugins -- are initialized and updated. A symbolic
link is created for [pathogen](http://www.vim.org/scripts/script.php?script_id=2332),
which can then load all of the plugins found in `~/.vim/bundle`.

The reason for all the symbolic links and git submodules is simple: from now on,
you only have to update this repo and its submodules to have all changes reflected
in Vim. And you can do this _within Vim_ by typing `,u`!

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

Within Vim, just type `,u`.

Easy enough, yes?
