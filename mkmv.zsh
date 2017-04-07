#!/usr/bin/env zsh

# If all of the following conditions are met, treats destination as file
# (i.e. mkdir the dirname, and move & rename to basename).
#
# - there is only one source
# - that source is a file
# - basename of the destination has an extension
#
# To suppress this behavior and treat destination as directory, use the -d option.
# To force treating destination as a file, use the -f option.

local -a src
local dst_dir
local dst_file
local force_rename=false
local guess=true
local verbose=false

while getopts 'hfdv' flag; do
    case "$flag" in
        f)
            force_rename=true
            ;;
        d)
            guess=false
            ;;
        v)
            verbose=true
            ;;
        h)
            echo "Usage: $0 [-h] [-f] [-d] <src [src...]> <dst>"
            exit 0
    esac

done
shift $(( $OPTIND - 1 ))

src=( ${(@)argv[1,-2]} )
dst_dir="${argv[-1]}"
dst_file=""

if $force_rename || \
        (( $#src == 1 )) && [[ -f $src[1] ]] && \
        [[ -n $dst_dir:e ]] && $guess; then
    dst_file="${dst_dir:t}"
    dst_dir="${dst_dir:h}"
fi

if $verbose; then
    echo "mkdir -p \"${dst_dir}\""
    echo "mv ${(@)src} \"${dst_dir}/${dst_file}\""
fi

mkdir -p "${dst_dir}" && mv ${(@)src} "${dst_dir}/${dst_file}"
