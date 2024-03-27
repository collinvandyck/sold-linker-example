#!/usr/bin/env bash

set -eo pipefail

install_sold() {
	echo "Building sold linker"
	# https://github.com/bluewhalesystems/sold/issues/2
	if ! [ -d sold ]; then
		git clone https://github.com/bluewhalesystems/sold.git
	fi
	(cd sold && {
		git pull
		mkdir -p build
		cd build
		cmake -DCMAKE_DISABLE_PRECOMPILE_HEADERS=On -DMOLD_USE_ASAN=On ..
		cmake --build . -j $(nproc)
		mkdir -p dist
		cmake --install . --prefix $(pwd)/dist
	})
}

SOLD_64=sold/build/dist/bin/ld64.sold

if [ ! -L $SOLD_64 ]; then
	install_sold
fi

mkdir -p .cargo
cat <<eos > .cargo/config.toml
[target.aarch64-apple-darwin]
linker = "/usr/bin/clang"
rustflags = ["-C", "link-arg=--ld-path=$(pwd)/${SOLD_64}"]
eos


