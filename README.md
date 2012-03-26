My Vim Preferences
==================

Installation
------------

### Linux / Mac OS X / Cygwin

Copy and paste this into a terminal:

    bash -s < <(curl -s https://raw.github.com/brymck/dotvim/master/bin/install)

#### Explanation

The above script removes any preexisting personal Vim configuration, so
backup anything you might wish to preserve going forward. This repo is then
cloned into `~/.vim`, and a symbolic link is created between `~/.vimrc` and
`~/.vim/vimrc`, which allows you to update the repo and have the changes
reflected instantly in Vim. Once the repo is cloned, all of the submodules --
links to Vim plugins -- are initialized and updated. A symbolic link is created
for [pathogen](http://www.vim.org/scripts/script.php?script_id=2332), which can
then load all of the plugins found in `~/.vim/bundle`.

The reason for all the symbolic links and git submodules is simple: from now
on, you only have to update this repo and its submodules to have all changes
reflected in Vim. And you can do this _within Vim_ by typing `,u`!

Note that you can add your own stuff to `~/.vimrc_custom`, in the off-chance you
disagree with any of my settings.

### Windows

Note: This requires Vista or a more recent version of Windows (for `mklink`),
and you must open the command prompt as an administrator (right-click > Run as
administrator...). Also, some `git` commands in Windows have a nasty habit of
causing the command prompt to "eat" subsequent pasted commands, so probably
needs to be run in three parts.

    cd "%UserProfile%"
    rmdir vimfiles /S /Q
    git clone http://github.com/brymck/dotvim.git vimfiles
    del _vimrc
    mklink _vimrc vimfiles\vimrc
    cd vimfiles
    git submodule init

    git submodule update

    mkdir autoload
    cd autoload
    mklink pathogen.vim ..\pathogen\autoload\pathogen.vim

You can add the optional stuff as follows:

    cd "%UserProfile%\vimfiles"
    bundle update
    cd ..
    del _pryrc
    mklink _irbrc vimfiles\irbrc
    mklink _pryrc vimfiles\pryrc

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

#### [Me](https://github.com/brymck)

* [konjac](https://github.com/brymck/konjac_vim) - Some Vim integration for
  konjac
* [v1m](https://github.com/brymck/v1m) - Some very minor functions for use
  in translating English to and from Japanese

#### Others

* [coffee-script](http://www.vim.org/scripts/script.php?script_id=3590) ([Mick
  Koch](http://www.vim.org/account/profile.php?user_id=19434)) - CoffeeScript
  support for vim
* [Color Sampler Pack](http://www.vim.org/scripts/script.php?script_id=625)
  ([Robert (Metacosm)](http://www.vim.org/account/profile.php?user_id=2162)) -
  Top 100 Themes, GUI Menu
* [CSApprox](http://www.vim.org/scripts/script.php?script_id=2390) ([Matt
  Wozniski](http://www.vim.org/account/profile.php?user_id=13145)) - Make
  gvim-only colorschemes work transparently in terminal vim Text Objects based
  on Indentation Level
* [indent-object](http://www.vim.org/scripts/script.php?script_id=3037)
  ([Michael Smith](http://www.vim.org/account/profile.php?user_id=19478)) -
  Text Objects based on Indentation Level
* [Javascript-Indent](http://www.vim.org/scripts/script.php?script_id=3081)
  ([Preston Koprivica](http://www.vim.org/account/profile.php?user_id=19766)) -
  Javascript indenter (HTML indent is included)
* [LaTeX-Suite](http://www.vim.org/scripts/script.php?script_id=475) ([Srinath
  Avadhanula](http://www.vim.org/account/profile.php?user_id=247)) - A rich set
  of tools for editing LaTeX
* [Mini Buffer Explorer](https://github.com/fholgado/minibufexpl.vim) ([Bindu
  Wavell](http://www.vim.org/account/profile.php?user_id=385) and [Federico
  Holgado](https://github.com/fholgado)) - Elegant buffer explorer - takes very
  little screen space
* [RDoc](http://www.vim.org/scripts/script.php?script_id=2878) ([Hallison
  Batista](http://www.vim.org/account/profile.php?user_id=12644)) - Syntax
  highlight for Ruby Documentation
* [ScrollColors](http://www.vim.org/scripts/script.php?script_id=1488) ([Yakov
  Lerner](http://www.vim.org/account/profile.php?user_id=2342)) - Colorsheme
  Scroller, Chooser, and Browser
* [snipMate](http://www.vim.org/scripts/script.php?script_id=2540) ([Michael
  Sanders](http://www.vim.org/account/profile.php?user_id=16544)) -
  TextMate-style snippets for Vim
* [SuperTab](http://www.vim.org/scripts/script.php?script_id=1643) ([Eric Van
  Dewoestine](http://www.vim.org/account/profile.php?user_id=6016)) - Do all
  your insert-mode completion with Tab.
* [taglist](http://www.vim.org/scripts/script.php?script_id=273) ([Yegappan
  Lakshmanan](http://www.vim.org/account/profile.php?user_id=244)) - Source
  code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
* [tabular](http://www.vim.org/scripts/script.php?script_id=3464) ([Josh
  Adams](http://www.vim.org/account/profile.php?user_id=27136)) - Vim script
  for text filtering and alignment
