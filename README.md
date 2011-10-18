My Vim Preferences
==================

Installation
------------

### Linux / Mac OS X / Cygwin

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
    ln -s ../vim-pathogen/autoload/pathogen.vim pathogen.vim
    cd ..

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
    mklink pathogen.vim ..\vim-pathogen\autoload\pathogen.vim
    cd ..
