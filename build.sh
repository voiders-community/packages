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
    TEMPLATE="$1"
    if [ -z "$TEMPLATE" ]; then
        echo >&2 "error: a template name was expected"
        exit 1
    fi

    if [ ! -d "./srcpkgs/$TEMPLATE" ]; then
        echo >&2 "error: template $TEMPLATE not found in ./srcpkgs."
        exit 1
    fi

    echo "syncing all local packages to void-packages/srcpkgs..."
    cp -a ./srcpkgs/* ./void-packages/srcpkgs/

    _xbps_src -r "." pkg "$TEMPLATE"
}

bootstrap() {
    _xbps_src binary-bootstrap
}

case "$1" in
    build)     build "$2" ;;
    bootstrap) bootstrap ;;
    *)         echo "usage: $0 {build <pkg> | bootstrap}" && exit 1 ;;
esac
