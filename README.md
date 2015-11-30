# VIMRC
.vim and .vimrc for setting up environment.

# Manual Settng Up
1. Install VIM74:
    1.1 Remove the installed old version:
        $ sudo apt-get remove vim vim-runtime gvim
    1.2 Download VIM74:
        $ cd ~
        $ hg clone https://code.google.com/p/vim/
    1.3 Install prerequisite libraries:
        $ sudo apt-get install ncurses-dev build-essential mercurial
    1.4 Build Vim from sources:
        $ cd ~/vim/src
        $ make distclean
        $ ./configure --with-python-config-dir=/usr/lib/python2.7/config --enable-pythoninterp -disable-gui --without-x
        # No slash behind "config" 
        $ make
        $ sudo make install

2. Edit .vimrc:
    The .vimrc is stored by. Just put it in $HOME

3. Install Vundle(Plugin Manager):
    Set up Vundle:
        $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    
4. Install plugins:
    $ vim ~/.vimrc
    In VIM:
    :PluginInstall

5. Install YCM:
    5.1 Install development tools and CMake: 
        $ sudo apt-get install build-essential cmake python-dev

    5.2 Compiling YCM with semantic support for C-family languages
        $ cd ~/.vim/bundle/YouCompleteMe
        $ ./install.sh --clang-completer

    5.3 Compiling YCM without semantic support for C-family languages
        $ cd ~/.vim/bundle/YouCompleteMe
        $ ./install.sh

6. Customise:
    1. Install color scheme:
        1.1 download:
           molokai: https://github.com/tomasr/molokai
           jellybeans:
        1.2 cp the .vim file into:
            ~/.vim/colors
            or
            /usr/share/vim74/.../colors
        1.3 edit colorscheme in ~/.vimrc

    2. Install CSApprox: (which make gvim-only colorschemes work in terminal vim)
        2.1 Download:
            http://www.vim.org/scripts/script.php?script_id=2390
        2.2 unzip it in ~/.vim
        2.3 Edit ~/.vimrc
            set t_Co=256
        Now you could see background in terminal vim.

    3. Install vim-airline
        3.1 Installed in .vimrc by Vundle
            Install it
    
    4. Install terminal fonts:
                4.2.1 Download fonts-master:
                https://github.com/Lokaltog/powerline-fonts
                4.2.2 Run ./install.sh in this package
                4.3.3 Edit ~/.vimrc(Integrate with powerline font)
                    Add a statement:
                    let g:airline_powerline_fonts = 1

                4.3.4 Change terminal font to "Powerline" Fonts.
