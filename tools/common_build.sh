#! /bin/bash

set -o nounset
set -o errexit
set -o pipefail


ROOTDIR="$PWD"

curl -L "https://libsdl.org/release/${SDL_NAME}.tar.gz" | tar xzf -
pushd "${SDL_NAME}"

./configure \
	--disable-shared \
	--enable-static \
	--disable-audio \
	--disable-render \
	--disable-video-dummy \
	--disable-video-vulkan \
    --prefix=/opt/${SDL_NAME} \
    "$@"
make
make install DESTDIR="$ROOTDIR/deploy"

(cd "$ROOTDIR/deploy/opt" && tar cJf "../${SDL_NAME}_${PLATFORM_SUFFIX}.tar.xz" ./*)
popd
