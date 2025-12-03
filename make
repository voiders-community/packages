#!/bin/sh -e

_xbps_src() {
    set +e
    (
        set -e
        cd ./void-packages
        ./xbps-src -H "../hostdir" "$@"
    )
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
    _xbps_src pkg "$1"
    rm -rf "./void-packages/srcpkgs/$1"
}

bootstrap() {
    _xbps_src binary-bootstrap
}

case "$1" in
    build)     build "$2" ;;
    bootstrap) bootstrap ;;
    *)         echo "unknown command $1" && exit 1 ;;
esac
