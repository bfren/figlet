#!/bin/sh

set -eu

# script receives one argument: the figlet version
FIGLET=${1}

# verify and extract source
./verify.sh ${FIGLET}
tar -xf figlet-${FIGLET}.tar.gz
cd figlet-${FIGLET}

# apply patches - from Alpine's figlet package, so it builds against musl
for patch in ../patches/*.patch ; do
    echo "Applying ${patch}"
    patch -p1 < "${patch}"
done

# build a static executable that looks for fonts in /usr/share/figlet
make figlet LDFLAGS=-static DEFAULTFONTDIR=/usr/share/figlet
strip figlet

# install the executable, the default (standard) font and the licence to /out
install -Dm755 figlet /out/usr/bin/figlet
install -Dm644 fonts/standard.flf /out/usr/share/figlet/standard.flf
install -Dm644 LICENSE /out/usr/share/licenses/figlet/LICENSE

# check figlet is static (it needs no shared libraries) and renders text using the default font
if readelf --dynamic /out/usr/bin/figlet | grep -q NEEDED ; then
    echo "figlet is not statically linked:" >&2
    readelf --dynamic /out/usr/bin/figlet | grep NEEDED >&2
    exit 1
fi
/out/usr/bin/figlet -d /out/usr/share/figlet "figlet"

echo "Built figlet ${FIGLET}"
