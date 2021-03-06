#!/bin/bash

#########################################################################
# Author: Zhaoting Weng
# Created Time: Fri 02 Mar 2018 05:29:12 PM CST
# Description:
#########################################################################

MYNAME=$(basename ${BASH_SOURCE[0]})
MYDIR=$(readlink -e $(dirname ${BASH_SOURCE[0]}))
OH_MY_TMUX_DIR=$MYDIR/oh-my-tmux
SIMPLE_TMUX_DIR=$MYDIR/simple

usage()
{
    cat << EOF
usage: $MYNAME

Install tmux config file to $HOME based on your tmux version
EOF
}

line_in_file()
{
    target_line="$1"
    file="$2"
 
    if [[ ! -f $file ]]; then
        # create a new file if not existed
        echo "$target_line" >> "$file"
    else
        while IFS= read -r line; do
            # use exact matching (instead of pattern matching)
            [[ "$line" = "$target_line" ]] && { is_find=; break; }
        done < $file
 
        if [[ -z ${is_find+x} ]]; then
            echo "$target_line" >> $file
        fi
    fi
}

setup_oh_my_tmux()
{
    #[[ -L $HOME/.tmux ]] && rm $HOME/.tmux # in case link follow link
    #ln -s -f $OH_MY_TMUX_DIR/.tmux $HOME/.tmux

    ln -s -f $OH_MY_TMUX_DIR/.tmux/.tmux.conf $HOME/.tmux.conf

    # use the customized one instead of the official provided one
    ln -s -f $OH_MY_TMUX_DIR/.tmux.conf.local $HOME/.tmux.conf.local

    # make tmux in vim mode
    line_in_file "export EDITOR=$(which vim)" $HOME/.bashrc
}

setup_simple()
{
    ln -s -f $SIMPLE_TMUX_DIR/.tmux.conf $HOME/.tmux.conf
}

main()
{
    version=$(cut -d " " -f 2 < <(tmux -V))

    if (( $(bc -l <<< "$version > 2.1") )); then
        echo "Setup oh-my-tmux..."
        setup_oh_my_tmux
    else
        echo "Setup simple..."
        setup_simple
    fi
    echo "Done!"
}

main
