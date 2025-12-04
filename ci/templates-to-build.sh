#!/bin/sh -e
# automatically list the templates without a corresponding xbps file.

ARCH="x86_64 x86_64-musl"

for template in ./srcpkgs/*; do
    eval $(printf "templ_%s\n" $(grep -e "version=" -e "revision=" "$template/template"))
    templ_name="$(basename "$template")"
    binpkg="$templ_name-${templ_version}_$templ_revision"

    for a in $ARCH; do
        if [ ! -e "hostdir/binpkgs/$binpkg.$a.xbps" ]; then
            echo "$a $templ_name $templ_version $templ_revision"
        fi
    done
done
