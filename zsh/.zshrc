# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="spaceship"
eval "$(starship init zsh)"

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
  git
)


DISABLE_AUTO_UPDATE=true source $ZSH/oh-my-zsh.sh

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

# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#     compinit
# done
# compinit -C

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

export EDITOR=/usr/bin/vim

# colorize ls
alias ls="ls --color"
alias l="ls"
alias ll="ls -l"

# input method
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

# dictionary
def() {
    pics=(Oro Mato)
    pic=${pics[$((RANDOM%2+1))]} 
    sdcv -n "$*" | xcowsay -t 3 --image ~/Pictures/$pic.png
}

# ruby gems
if command -v ruby > /dev/null; then
    GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
    GEM_PATH=$GEM_HOME
    export PATH=$PATH:$GEM_HOME/bin
fi

# path
export PATH=$HOME/github/tool/MyUtilities:$HOME/.local/bin:$HOME/.local/pulumi:$HOME/.local/npm-bin/node_modules/.bin:$PATH

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
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export GOPROXY=https://goproxy.cn
setup_gvm() {
    [[ -s "/home/magodo/.gvm/scripts/gvm" ]] && source "/home/magodo/.gvm/scripts/gvm"
}

gofoo() {
    if [[ -d /tmp/gofoo ]]; then
        cd /tmp/gofoo
        return
    fi
    mkdir /tmp/gofoo
    cd /tmp/gofoo
    go mod init foo
}

goformat() {
  find . -name "*.go" | grep -v vendor | xargs gofmt -w -s || exit 1
  goimports -w .
}

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

alias git_bigfile="git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 \
| cut -c 1-12,41- \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"

# fabric
export PATH=$PATH:$HOME/fabric-samples/bin

# node version manager
if command -v nvm; then
    . /usr/share/nvm/init-nvm.sh
fi

# python version manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

setup_pyenv() {
    command -v pyenv 1>/dev/null 2>&1 && eval "$(pyenv init -)"
}

# android
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:"$HOME/Android/Sdk/platform-tools":"$HOME/Android/Sdk/emulator"

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

####################################################################################
# minikube
####################################################################################
# if [[ -x /usr/bin/kubectl ]]; then source <(kubectl completion zsh); fi
# if [ -f /usr/bin/minikube ]; then
#     source <(minikube completion zsh)
#     #eval $(minikube docker-env)
# fi

####################################################################################
# cow
####################################################################################
cow_env() {
    export http_proxy=http://127.0.0.1:7777
    export https_proxy=https://127.0.0.1:7777
}

####################################################################################
# flutter
####################################################################################
export PATH=$PATH:$HOME/FlutterSDK/bin
export PATH=$PATH:$HOME/.pub-cache/bin
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

####################################################################################
# go athens
####################################################################################
athens_env() {
    docker container inspect athens-proxy &> /dev/null || /home/magodo/UCloud/Project/udb-gomod-athens/run.sh
    export GO111MODULE=on
    export GOPROXY=http://127.0.0.1:3000
}

athens_env_pub() {
    export GO111MODULE=on
    export GOPROXY=http://172.18.137.171:3000
}

export GOSUMDB=off

####################################################################################
# ngrok
####################################################################################
export PATH=$PATH:$HOME/.local/ngrok


####################################################################################
# udb pre mgrdb
####################################################################################
predb() {
    mysql -uucloud -pucloud.cn0 -h192.168.152.10 -P3206 udb
}

####################################################################################
# terraform
####################################################################################
alias tf=terraform

azurerm_schema() {
  tf providers schema -json | jq ".provider_schemas.\"registry.terraform.io/hashicorp/azurerm\".resource_schemas.$1.block"
}

####################################################################################
# THIS SHOULD BE AT LAST LINE, OTHERWISE RVM WILL COMPLAIN
# ruby: rvm
####################################################################################
setup_rvm() {
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
}

####################################################################################
# azure related
####################################################################################
export PATH=$PATH:~/MS/projects/utils
export PATH=$PATH:/home/magodo/.local/azure-cli/bin

# allow cli to work behind a proxy 
#export AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1

####################################################################################
# terraform team city test
####################################################################################

setup_tctest() {
    export TCTEST_BUILDTYPEID="TerraformOpenSource_TerraformProviders_AzureRMPublic_AZURERM_SERVICE_PUBLIC"
    export TCTEST_USER="magodo"
    export TCTEST_SERVER="ci-oss.hashicorp.engineering"
    export TCTEST_REPO="terraform-providers/terraform-provider-azurerm"
    export TCTEST_FILEREGEX="^[a-z]*/internal/services/[a-z]*/[_a-zA-Z]*(resource|data_source)"
    export TCTEST_SERVICEPACKAGESMODE="true"
}

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform

####################################################################################
# TF Linter
####################################################################################

tflint() {
    package=$1
    [[ -z $package ]] && { echo "please specify [package] to be lint"; return 1; }
    tmpdir=$(mktemp -d)
    tflint_path="$tmpdir/tflint"
    pushd /home/magodo/github/terraform-azurerm-provider-linter > /dev/null 2>&1
    go build -o "$tmpdir/tflint" || return 1
    popd >/dev/null 2>&1
    GO111MODULE=on go vet -vettool="$tflint_path" "$package"
    rm "$tflint_path"
}

####################################################################################
# RUST
####################################################################################
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export PATH=$PATH:$HOME/.cargo/bin
export RUST_BACKTRACE=1

####################################################################################
# SPACESHIP ZSH THEME
####################################################################################
# SPACESHIP_CHAR_SYMBOL="💤 "
#
# SPACESHIP_GOLANG_SYMBOL="🦉 "
#
# SPACESHIP_EXIT_CODE_SYMBOL="😡 "
# SPACESHIP_EXIT_CODE_SHOW=true
#
# # SPACESHIP_GIT_STATUS_UNTRACKED=" ⚡ "
# # SPACESHIP_GIT_STATUS_ADDED=" ➕ "
# # SPACESHIP_GIT_STATUS_DELETED=" ➖ "
# # SPACESHIP_GIT_STATUS_MODIFIED=" ⚡ "
# # SPACESHIP_GIT_STATUS_RENAMED=" ⚡ "
# # SPACESHIP_GIT_STATUS_STASHED=" 🗂 "
# # SPACESHIP_GIT_STATUS_UNMERGED=" 💬 "
# SPACESHIP_GIT_STATUS_AHEAD=""
# SPACESHIP_GIT_STATUS_BEHIND=""
# SPACESHIP_GIT_STATUS_DIVERGED=" 💥 "
# # SPACESHIP_GIT_STATUS_SUFFIX=""
# # SPACESHIP_GIT_STATUS_PREFIX=""
# SPACESHIP_PROMPT_ORDER=(
#   dir
#   git
#   exec_time
#   line_sep
#   jobs
#   char
#   exit_code
#   golang
#   rust
#   ruby
#   pyenv
#   terraform
#   venv
# )

####################################################################################
# NPM
####################################################################################
#export PATH=$PATH:$HOME/node_modules/azure-functions-core-tools/bin


####################################################################################
# urlencode
####################################################################################
urlencode() {
    input=$1
    if [[ -z $input ]]; then
        echo -n "String to encode: "
        read input
    fi
    python3 -c "import urllib.parse; print(urllib.parse.quote('$input', ''))"
}

####################################################################################
# .NET core
####################################################################################
export PATH=$HOME/.dotnet/tools:$PATH

####################################################################################
# mitmproxy
####################################################################################
#alias mitmproxy="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 mitmproxy/mitmproxy mitmproxy --set block_global=false"
#alias mitmweb="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 8081:8081 mitmproxy/mitmproxy mitmweb --web-host 0.0.0.0 --set block_global=false"

####################################################################################
# Autorest
####################################################################################
function run_autorest() {
    extra_option=()
    while :; do
        case $1 in
            -h|--help)
            cat << EOF
Usage: run_autorest [options] spec_dir readme out_dir

Options:
    -h|--help           show this message
    --debug

Arguments:
    spec_dir            Path to auzre-rest-api/specification
    readme              Path to the readme.md file of the target RP
    out_dir             Path to the output directory
EOF
                return
                ;;
            --debug)
                extra_option=(--debug)
                shift
                break
                ;;
            --)
                shift
                break
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    local expect_n_arg
    expect_n_arg=3
    [[ $# = "$expect_n_arg" ]] || { "wrong arguments (expected: $expect_n_arg, got: $#)"; return 1; }

    spec_dir="$(realpath $1)"
    [[ -d "$spec_dir" ]] ||  { "$spec_dir is not a directory"; return 1; }
    readme="$(realpath $2)"
    [[ -f "$readme" ]] || { "$readme is not a file"; return 1; }
    out_dir="$(realpath $3)"
    [[ -d "$out_dir" ]] || { "$out_dir is not a directory"; return 1; }

    tool_dir=$HOME/projects/autorest.trenton
    docker run --rm -v "$spec_dir":"$spec_dir" -v "$out_dir":"$out_dir" -v "$tool_dir":/tool autorest bash -c "metadata-tool \"$readme\" && autorest \"${extra_option[@]}\" --trenton --use=/tool --intermediate --trenton-output-folder=\"$out_dir\" \"$readme\""
}

# Terraform Vault
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault

##########################################
# git
##########################################
gfm() {
    upstream=${1:-upstream}
    git fetch $upstream
    git merge $upstream/main
}


##########################################
# xclip
##########################################
alias xclip="xclip -selection c"

##########################################
# kitty stuff
##########################################
alias icat="kitty icat --align=left"
alias isvg="rsvg-convert"
alias idot="dot -Tsvg"

##########################################
# Terraform
##########################################
tfinit() {
  rm .terraform.lock.hcl 2>/dev/null
  terraform init "$@"
}

# proxychains
alias pchain=proxychains

# Terraform completion
complete -o nospace -C $(which terraform)

# Terraform example gen
alias tfegen="terraform-provider-azurerm-example-gen"

##########################################
# anaconda
##########################################
conda_activate() {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
            . "/opt/anaconda/etc/profile.d/conda.sh"
        else
            export PATH="/opt/anaconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}
