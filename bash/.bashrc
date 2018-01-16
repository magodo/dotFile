alias ls="ls --color"
alias l="ls"
alias ll="ls -l"

# input method
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# dictionary
alias def="/usr/bin/sdcv"

# ruby gems
GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
GEM_PATH=$GEM_HOME
export PATH=$PATH:$GEM_HOME/bin

# path
export PATH=$HOME/github/tool/MyUtilities:$HOME/.local/bin/:$PATH

# reset psmouse
reset_psmouse()
{
    sudo modprobe -r psmouse && sudo modprobe psmouse
}

# set terminal transparency
hide()
{
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
    profile=${profile:1:-1} # remove leading and trailing single quotes
    #gsettings list-keys "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" 
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" background-transparency-percent $1
}

