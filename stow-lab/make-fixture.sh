#!/bin/sh
# make-fixture.sh -- copy the pristine fixture packages from
# stow-lab/fixture/ into a fresh dotfiles tree at the path given
# as $1. Used by run-lab.sh so every lab run starts clean, and
# usable by readers who want the same starting point.
set -eu
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
dest=${1:?usage: make-fixture.sh TARGET-DOTFILES-DIR}
mkdir -p "$dest"
cp -r "$here/fixture/dotfiles/." "$dest/"
chmod +x "$dest/scripts/bin/greet" "$dest/scripts/bin/today"
echo "fixture dotfiles tree ready at $dest"
