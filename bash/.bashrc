# colorize $(tree) output
eval "$(dircolors)"

# colorize grep
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
alias grep='grep --color'

#
export EDITOR=/usr/bin/vim

#
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

    if [[ $1 ]]; then
        gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" background-transparency-percent $1
    else
        local cur_val
        local new_val

        cur_val=$(gsettings get "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" background-transparency-percent)

        if [[ $cur_val != 30 ]]; then
            new_val=30
        else
            new_val=2
        fi
        gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" background-transparency-percent $new_val
    fi
}

# golang
export GOPATH=$HOME/github/go_workspace
export PATH=$PATH:$GOPATH/bin
