# colorize $(tree) output
eval "$(dircolors)"

# colorize grep
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
alias grep='grep --color'

export EDITOR=/usr/bin/vim

# colorize ls
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
        gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" background-transparency-percent "$1"
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
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# todo
export TODO_DIR=~/.todo/data
alias todo="todo.sh"
#todo ls | cowsay -n  -d
#todo ls

# python
export PYTHONDONTWRITEBYTECODE=1

# ucloud go
ucloud_dev()
{
    export GOPATH=$HOME/UCloud/Project/go_workspace/
    export PATH=$HOME/.local/bin-ucloud:$HOME/UCloud/Project/go_workspace/bin:$PATH
    #export UDB_CONFIG_DIR=$HOME/UCloud/Project/udb-config
    . ~/.udb_bashrc
}

# http(s) proxy
privoxy_setup()
{
    export http_proxy=http://127.0.0.1:8118
    export https_proxy=https://127.0.0.1:8118
}

# DB
alias db_root='mycli -uroot -p123'
alias db_magodo='mycli -umagodo -p123'

# js tools
export PATH=$PATH:$HOME/node_modules/.bin

# shellcheck
git_check()
{
    if (( $(git status --porcelain|wc -l) != 0 )); then
        git_check_index
    else
        git_check_commit
    fi
    return $?
}

git_check_index()
{
    local is_fail mode XY filename X Y

    is_fail=0
    while read -r XY filename; do
        X=${XY:0:1}
        Y=${XY:1:1}
        if [[ -n $Y ]]; then
            mode=$Y
        else
            mode=$X
        fi
        if [[ $mode != "D" ]]; then
            [[ ${filename##*.} = "sh" ]] && { shellcheck "$(git rev-parse --show-toplevel)/$filename" || is_fail=1; }
            [[ ${filename##*.} = "js" ]] && { jshint "$(git rev-parse --show-toplevel)/$filename" || is_fail=1; }
        fi
    done < <(git status --porcelain)
    return $is_fail
}

git_check_commit()
{
    local is_fail mode filename

    is_fail=0
    while read -r _ _ _ _ mode filename; do
        if [[ $mode != "D" ]]; then
            [[ ${filename##*.} = "sh" ]] && { shellcheck "$(git rev-parse --show-toplevel)/$filename" || is_fail=1; }
            [[ ${filename##*.} = "js" ]] && { jshint "$(git rev-parse --show-toplevel)/$filename" || is_fail=1; }
        fi
    done < <(git diff HEAD^1 --raw)
    return $is_fail
}

alias cdgo="cd $GOPATH/src/github.com/magodo/go_snippet"

export PS1="\u@\H \W 💤 "


