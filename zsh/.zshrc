# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cloud-emoji"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-completions
  git
  docker
)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# enable zsh-completions
autoload -U compinit
compinit

## autoload prompt theme
#autoload -Uz promptinit
#promptinit
#
#PROMPT='%n%f@%m%f %F{yellow}%1~ %f💤 '

# keybinding
bindkey -e
bindkey \^U backward-kill-line

# colorize $(tree) output
eval "$(dircolors)"

# colorize grep
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
alias grep='grep --color'

# colorize cat
alias cat=ccat

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
    #sudo modprobe -r psmouse && sudo modprobe psmouse proto=imps
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
    #export GOPATH=$HOME/UCloud/Project/go_workspace
    export PATH=$HOME/.local/bin-ucloud:$GOPATH/bin:$PATH
    export UDB_CONFIG_DIR=$HOME/UCloud/Project/udb-config
    #. ~/.udb_bashrc
}

# http(s) proxy
privoxy_setup()
{
    sudo systemctl start privoxy
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


alias git_bigfile="git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 \
| cut -c 1-12,41- \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"

# fabric
export PATH=$PATH:$HOME/fabric-samples/bin

# node version manager
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# python version manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv 1>/dev/null 2>&1 && eval "$(pyenv init -)"

# golang version manager
#[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# android
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:"$HOME/Android/Sdk/platform-tools"

# go mod graph
go_dep() {
    f_unver=$(mktemp)
    f_graph=$(mktemp)
    f_img=$(mktemp)
    go list -m &>/dev/null || { echo "no go module found!" 2>&1; return 1; }
    go mod graph | sed -Ee 's/@[^[:blank:]]+//g' | sort | uniq > $f_unver
    cat << EOF > $f_graph
digraph {
    graph [overlap=false, size=14];
    root="$(go list -m)";
    node [ shape = plaintext, fontsize=24];
    "(go list -m)" [style=filled, fillcolor="#E94762"];
EOF
    cat $f_unver | awk '{print "\""$1"\" -> \""$2"\""};' >> $f_graph
    echo "}" >> $f_graph
    dot -Tsvg -o $f_img $f_graph
    eog $f_img
    rm $f_img $f_graph $f_unver
}
