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

  * Install CSApprox: (which make gvim-only colorschemes work in terminal vim)

    * Download:

        http://www.vim.org/scripts/script.php?script_id=2390

    * unzip it in ~/.vim

    * Edit ~/.vimrc

        set t_Co=256

    * Now you could see background in terminal vim.

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

# TMUX config

There is a cool config repo [here](https://github.com/samoshkin/tmux-config), which supports nested tmux sessions. This is really helpful...

# ZSH
