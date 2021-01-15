#!/usr/bin/env zsh

# Creates the destination directory and moves the source files/directories
# into it. For example,
#
#   $ mkmv foo.txt bar/ ~/baz
#
# will create ~/baz and move foo.txt and bar/ into it.
#
#   $ mkmv foo/ ~/bar/baz/
#
# will create ~/bar/baz/ and move foo/ into it (i.e. ~/bar/baz/foo/ is the
# resulting structure you will get).
#
# If you want to instead move & rename foo/ to baz/, use the -d option.
#
#   $ mkmv -d foo/ ~/bar/baz/
#
# will create ~/bar/ and then move & rename foo/ to ~/bar/baz/ (i.e. the
# resulting structure is ~/bar/foo/).

local -a src
# Argument passed to mkdir
local dir_to_create
# Argument passed to mv
local move_dst
local force_rename_dir=false
local verbose=false
local cmd="mv"
local -a cmd_args

while getopts 'cdlvh' flag; do
    case "$flag" in
        c)
            cmd="cp"
            cmd_args=( "-r" )
            ;;
        d)
            force_rename_dir=true
            ;;
        l)
            cmd="ln"
            cmd_args=( "-s" )
            ;;
        v)
            verbose=true
            ;;
        h)
            echo "Usage: $0 [-h] [-c] [-d] [-l] <src [src...]> <dst>"
            exit 0
    esac

done
shift $(( $OPTIND - 1 ))

src=( ${(@)argv[1,-2]} )
dir_to_create="${argv[-1]}"
move_dst="${dir_to_create}/"

if $force_rename_dir; then
    if (( $#src == 1 )) && [[ -d $src[1] ]] && [[ ! -d $move_dst ]]; then
        move_dst="${dir_to_create}"
        dir_to_create="${dir_to_create:h}"
    else
        cat >&2 <<EOF
When -d is specified, usage is:
    $0 -d <src> <dst>
where src and dst are both directories, and dst needs to be non-existant.
EOF
        exit 1
    fi
fi

if $verbose; then
    echo "mkdir -p \"${dir_to_create}\""
    echo "${cmd} ${(@)cmd_args} ${(@)src} \"${move_dst}\""
fi

mkdir -p "${dir_to_create}" && ${cmd} ${(@)cmd_args} ${(@)src} "${move_dst}"
