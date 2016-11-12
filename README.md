Kinds of dot files
---

# VIM

## Ubuntu 12.04 - LTS

1. Install VIM74:

  * Remove the installed old version:

        $ sudo apt-get remove vim vim-runtime gvim

  * Download VIM74:

        $ hg clone https://code.google.com/p/vim/

  * Install prerequisite libraries:

        $ apt-get install ncurses-dev build-essential mercurial python-dev

  * Build Vim from sources:

        $ cd ~/vim/src
        $ make distclean
        $ # No slash behind "config" 
        $ ./configure --with-python-config-dir=/usr/lib/python2.7/config --enable-pythoninterp -disable-gui --without-x
        $ make
        $ sudo make install

2. Edit .vimrc:

  * The .vimrc is stored by. Just put it in $HOME

3. Install Vundle(Plugin Manager):

  * Set up Vundle:

        $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

4. Install plugins:

        $ vim ~/.vimrc

  * In VIM:

        :PluginInstall

5. Install YCM:

  * Install development tools and CMake: 

        $ sudo apt-get install build-essential cmake python-dev

  * Compiling YCM: Refer to [YCM Official Manual](https://github.com/Valloric/YouCompleteMe)

6. Customise:

  * Install color scheme:

    * download:

        molokai: https://github.com/tomasr/molokai
        jellybeans:

    * cp the .vim file into:

        ~/.vim/colors
        or
        /usr/share/vim74/.../colors

     * edit colorscheme in ~/.vimrc

  * Install CSApprox: (which make gvim-only colorschemes work in terminal vim)

    * Download:

        http://www.vim.org/scripts/script.php?script_id=2390

    * unzip it in ~/.vim

    * Edit ~/.vimrc

        set t_Co=256

    * Now you could see background in terminal vim.

  * Install vim-airline

    * Installed in .vimrc by Vundle

  * Install terminal fonts(this font is compatible with *vim-airline*):

    * Download fonts-master:

        https://github.com/Lokaltog/powerline-fonts

    * Run ./install.sh in this package

    * Edit ~/.vimrc(Integrate with powerline font)

        let g:airline_powerline_fonts = 1

    * Change terminal font to "Powerline" Fonts.

# Arch - Linux version 4.8.6-1-ARCH

* Install vim
* Install vundle
* Install plugins via vundle
* Install powerline, powerline-vim, powerline-font via pacman
* Install color scheme:

  * download:

    molokai: https://github.com/tomasr/molokai
    jellybeans:

  * cp the .vim file into:

    ~/.vim/colors

  * edit colorscheme in ~/.vimrc

# TMUX config

# ZSH
