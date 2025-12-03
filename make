#!/bin/sh -e

usage() {
    echo "$0 [command] [args]\n"
    echo "    A simple script to manage a custom xbps repo\n"
    echo "Commands:\n"
    echo "    build [template]\n"
}

build() {
    if [ -z "$1" ]; then
        echo 1>&2 "A template name was expected"
        exit 1
    fi

    if [ ! -e "./srcpkgs/$1" ]; then
        echo 1>&2 "template $1 not found in ./srcpkgs"
        exit 1
    fi

    if [ -e "./void-packages/srcpkgs/$1" ]; then
        echo 1>&2 "template $1 already exists in ./void-packages/srcpkgs"
        exit 1
    fi

    cp -r "./srcpkgs/$1" "./void-packages/srcpkgs/$1"

    set +e
    (
        set -e
        cd ./void-packages
        ./xbps-src -H "../hostdir" pkg "$1"
    )

    rm -rf "./void-packages/srcpkgs/$1"
}

case "$1" in
    build) build "$2" ;;
    *)     usage "$0" ;;
esac
