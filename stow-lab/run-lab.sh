#!/bin/bash
# run-lab.sh -- execute the GNU Stow guide's whole lab for real
# and keep the transcripts in stow-lab/transcripts/.
#
# Everything happens in a scratch tree under stow-lab/work/:
# a fake home, several scenario folders, and a software prefix.
# The real $HOME is never touched: each section exports HOME to
# its scratch home before running anything.
#
# Re-running this script rebuilds the scratch tree from scratch
# (via make-fixture.sh) and overwrites the transcripts.
#
# Requires: stow, a C compiler and make (for chapter 11's tiny
# program). Run from anywhere:  ./stow-lab/run-lab.sh

set -o pipefail
LAB=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
WORK=$LAB/work
TR=$LAB/transcripts
REAL_HOME=$HOME

rm -rf "$WORK"
mkdir -p "$WORK/home" "$TR"
"$LAB/make-fixture.sh" "$WORK/home/dotfiles" >/dev/null

# ---------------------------------------------------------------- t00
{
echo '$ apt-cache policy stow'
apt-cache policy stow; echo "(exit $?)"
echo
echo '$ stow --version'
stow --version; echo "(exit $?)"
echo
echo '$ command -v stow'
command -v stow; echo "(exit $?)"
echo
echo '$ head -1 "$(command -v stow)"'
head -1 "$(command -v stow)"; echo "(exit $?)"
echo
echo '$ perl --version | sed -n 2p'
perl --version | sed -n 2p; echo "(exit $?)"
echo
echo '$ stow --help | sed -n 1,14p'
stow --help | sed -n '1,14p'; echo "(exit $?)"
} > "$TR/t00-install-and-version.txt" 2>&1

# ---------------------------------------------------------------- t01
{
export HOME=$WORK/home
echo "# Scratch home for this transcript: $HOME"
echo '$ cd "$HOME"'
cd "$HOME"; echo "(exit $?)"
echo
echo '$ find dotfiles -type f | sort'
find dotfiles -type f | sort; echo "(exit $?)"
echo
echo '$ cd dotfiles'
cd dotfiles; echo "(exit $?)"
echo
echo '$ stow editor'
stow editor; echo "(exit $?)"
echo
echo '$ cd "$HOME"'
cd "$HOME"; echo "(exit $?)"
echo
echo '$ ls -la'
ls -la; echo "(exit $?)"
echo
echo '$ readlink .vimrc .config'
readlink .vimrc .config; echo "(exit $?)"
echo
echo '$ cat .vimrc'
cat .vimrc; echo "(exit $?)"
echo
echo '$ find . -type l | sort'
find . -type l | sort; echo "(exit $?)"
} > "$TR/t01-first-stow.txt" 2>&1

# ---------------------------------------------------------------- t02
{
export HOME=$WORK/home
echo "# State from t01: editor is stowed, .config is one folded link."
echo '$ ls -ld "$HOME/.config"'
ls -ld "$HOME/.config"; echo "(exit $?)"
echo
echo '$ cd "$HOME/dotfiles"'
cd "$HOME/dotfiles"; echo "(exit $?)"
echo
echo '$ stow shell'
stow shell; echo "(exit $?)"
echo
echo '$ ls -ld "$HOME/.config"'
ls -ld "$HOME/.config"; echo "(exit $?)"
echo
echo '$ ls -la "$HOME/.config"'
ls -la "$HOME/.config"; echo "(exit $?)"
echo
echo '$ readlink "$HOME/.config/nvim" "$HOME/.config/bash"'
readlink "$HOME/.config/nvim" "$HOME/.config/bash"; echo "(exit $?)"
echo
echo '$ stow -D shell'
stow -D shell; echo "(exit $?)"
echo
echo '$ ls -ld "$HOME/.config"'
ls -ld "$HOME/.config"; echo "(exit $?)"
echo
echo '$ readlink "$HOME/.config"'
readlink "$HOME/.config"; echo "(exit $?)"
echo
echo '$ stow shell'
stow shell; echo "(exit $?)"
echo
echo '$ ls -la "$HOME"'
ls -la "$HOME"; echo "(exit $?)"
} > "$TR/t02-folding-and-unfolding.txt" 2>&1

# ---------------------------------------------------------------- t03
{
export HOME=$WORK/home
echo '$ cd "$HOME/dotfiles"'
cd "$HOME/dotfiles"; echo "(exit $?)"
echo
echo '$ stow scripts'
stow scripts; echo "(exit $?)"
echo
echo '$ ls -la "$HOME/bin"'
ls -la "$HOME/bin"; echo "(exit $?)"
echo
echo '$ "$HOME/bin/greet"'
"$HOME/bin/greet"; echo "(exit $?)"
echo
echo '$ export PATH="$HOME/bin:$PATH"'
export PATH="$HOME/bin:$PATH"; echo "(exit $?)"
echo
echo '$ greet'
greet; echo "(exit $?)"
echo
echo '$ today'
today; echo "(exit $?)"
} > "$TR/t03-scripts-package.txt" 2>&1

# ---------------------------------------------------------------- t04
{
export HOME=$WORK/home
echo '$ printf ... > "$HOME/dotfiles/shell/.bash_aliases"'
printf '%s\n' '# More aliases.' 'alias ..="cd .."' \
  > "$HOME/dotfiles/shell/.bash_aliases"; echo "(exit $?)"
echo
echo '$ cat "$HOME/dotfiles/shell/.bash_aliases"'
cat "$HOME/dotfiles/shell/.bash_aliases"; echo "(exit $?)"
echo
echo '$ ls -l "$HOME/.bash_aliases"'
ls -l "$HOME/.bash_aliases"; echo "(exit $?)"
echo
echo '$ cd "$HOME/dotfiles"'
cd "$HOME/dotfiles"; echo "(exit $?)"
echo
echo '$ stow -R shell'
stow -R shell; echo "(exit $?)"
echo
echo '$ ls -l "$HOME/.bash_aliases"'
ls -l "$HOME/.bash_aliases"; echo "(exit $?)"
echo
echo '$ sed -i "s/Hello from the scripts package./Hello again from the scripts package./" "$HOME/dotfiles/scripts/bin/greet"'
sed -i 's/Hello from the scripts package./Hello again from the scripts package./' \
  "$HOME/dotfiles/scripts/bin/greet"; echo "(exit $?)"
echo
echo '$ "$HOME/bin/greet"'
"$HOME/bin/greet"; echo "(exit $?)"
} > "$TR/t04-restow.txt" 2>&1

# ---------------------------------------------------------------- t05
{
export HOME=$WORK/home
echo '$ printf ... > "$HOME/.profile"'
printf '%s\n' '# My own file, written by hand. Not stowed.' \
  > "$HOME/.profile"; echo "(exit $?)"
echo
echo '$ cd "$HOME/dotfiles"'
cd "$HOME/dotfiles"; echo "(exit $?)"
echo
echo '$ stow -D scripts editor shell'
stow -D scripts editor shell; echo "(exit $?)"
echo
echo '$ ls -la "$HOME"'
ls -la "$HOME"; echo "(exit $?)"
echo
echo '$ find "$HOME/dotfiles" -type f | sort'
find "$HOME/dotfiles" -type f | sort; echo "(exit $?)"
} > "$TR/t05-unstow.txt" 2>&1

# ---------------------------------------------------------------- t06
mkdir -p "$WORK/t06/home"
"$LAB/make-fixture.sh" "$WORK/t06/dotfiles" >/dev/null
{
export HOME=$WORK/t06/home
cd "$WORK/t06"
echo "# Scenario folder: $WORK/t06 (dotfiles/ and an empty home/)"
echo '$ printf ... > home/.vimrc'
printf '%s\n' '" My own vimrc, written by hand.' 'set nocompatible' \
  > home/.vimrc; echo "(exit $?)"
echo
echo '$ cat home/.vimrc'
cat home/.vimrc; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ cat home/.vimrc'
cat home/.vimrc; echo "(exit $?)"
} > "$TR/t06-conflict.txt" 2>&1

# ---------------------------------------------------------------- t07
{
export HOME=$WORK/t06/home
cd "$WORK/t06"
echo "# Continuing t06: home/.vimrc is a real, hand-written file."
echo '$ stow --adopt -d dotfiles -t home editor'
stow --adopt -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ readlink home/.vimrc'
readlink home/.vimrc; echo "(exit $?)"
echo
echo '$ cat dotfiles/editor/.vimrc'
cat dotfiles/editor/.vimrc; echo "(exit $?)"
echo
echo '$ cat home/.vimrc'
cat home/.vimrc; echo "(exit $?)"
} > "$TR/t07-adopt.txt" 2>&1

# ---------------------------------------------------------------- t08
mkdir -p "$WORK/t08/home"
"$LAB/make-fixture.sh" "$WORK/t08/dotfiles" >/dev/null
printf '%s\n' '# The editor package' \
  'Notes to a human reader. Not a file the editor reads.' \
  > "$WORK/t08/dotfiles/editor/README.md"
printf '%s\n' 'scratch note, not a config file' \
  > "$WORK/t08/dotfiles/editor/notes.txt"
printf '%s\n' 'a backup copy of the vimrc' \
  > "$WORK/t08/dotfiles/editor/extra~"
printf '%s\n' 'not really a secret, but private all the same' \
  > "$WORK/t08/dotfiles/editor/secret.txt"
mkdir -p "$WORK/t08/dotfiles/editor/.git"
printf '%s\n' 'ref: refs/heads/main' \
  > "$WORK/t08/dotfiles/editor/.git/HEAD"
{
export HOME=$WORK/t08/home
cd "$WORK/t08"
echo '$ find dotfiles/editor -type f | sort'
find dotfiles/editor -type f | sort; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t home editor'
stow -D -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ printf ... > dotfiles/editor/.stow-local-ignore'
printf '%s\n' 'README\.md' 'notes\.txt' 'extra~' \
  > dotfiles/editor/.stow-local-ignore; echo "(exit $?)"
echo
echo '$ cat dotfiles/editor/.stow-local-ignore'
cat dotfiles/editor/.stow-local-ignore; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t home editor'
stow -D -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ stow --ignore=secret\.txt -d dotfiles -t home editor'
stow '--ignore=secret\.txt' -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t home editor'
stow -D -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ printf ... > dotfiles/editor/.stow-local-ignore   (with the .git pattern restored)'
printf '%s\n' '\.git' 'README\.md' 'notes\.txt' 'extra~' \
  > dotfiles/editor/.stow-local-ignore; echo "(exit $?)"
echo
echo '$ cat dotfiles/editor/.stow-local-ignore'
cat dotfiles/editor/.stow-local-ignore; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t home editor'
stow -D -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ rm dotfiles/editor/.stow-local-ignore'
rm dotfiles/editor/.stow-local-ignore; echo "(exit $?)"
echo
echo '$ printf ... > "$HOME/.stow-global-ignore"'
printf '%s\n' 'secret\.txt' > "$HOME/.stow-global-ignore"; echo "(exit $?)"
echo
echo '$ cat "$HOME/.stow-global-ignore"'
cat "$HOME/.stow-global-ignore"; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ rm "$HOME/.stow-global-ignore"'
rm "$HOME/.stow-global-ignore"; echo "(exit $?)"
} > "$TR/t08-ignore-rules.txt" 2>&1

# ---------------------------------------------------------------- t09
mkdir -p "$WORK/t09/elsewhere"
"$LAB/make-fixture.sh" "$WORK/t09/dotfiles" >/dev/null
{
cd "$WORK/t09"
echo '$ stow -d dotfiles -t elsewhere editor shell'
stow -d dotfiles -t elsewhere editor shell; echo "(exit $?)"
echo
echo '$ ls -la elsewhere'
ls -la elsewhere; echo "(exit $?)"
echo
echo '$ readlink elsewhere/.vimrc elsewhere/.bashrc'
readlink elsewhere/.vimrc elsewhere/.bashrc; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t elsewhere editor shell'
stow -D -d dotfiles -t elsewhere editor shell; echo "(exit $?)"
echo
echo '$ ls -la elsewhere'
ls -la elsewhere; echo "(exit $?)"
} > "$TR/t09-other-targets.txt" 2>&1

# ---------------------------------------------------------------- t10
mkdir -p "$WORK/t10/opt/stow"
cp -r "$LAB/hello" "$WORK/t10/hello-src"
{
cd "$WORK/t10/hello-src"
echo '$ make VERSION=1.0'
make VERSION=1.0; echo "(exit $?)"
echo
echo '$ make install VERSION=1.0 PREFIX=../opt/stow/hello-1.0'
make install VERSION=1.0 PREFIX=../opt/stow/hello-1.0; echo "(exit $?)"
echo
echo '$ find ../opt -type f | sort'
find ../opt -type f | sort; echo "(exit $?)"
echo
echo '$ cd ../opt/stow'
cd ../opt/stow; echo "(exit $?)"
echo
echo '$ stow hello-1.0'
stow hello-1.0; echo "(exit $?)"
echo
echo '$ ls -la .. ../bin ../share'
ls -la .. ../bin ../share; echo "(exit $?)"
echo
echo '$ ../bin/hello'
../bin/hello; echo "(exit $?)"
echo
echo '$ cat ../share/hello/message.txt'
cat ../share/hello/message.txt; echo "(exit $?)"
echo
echo '$ cd ../../hello-src'
cd ../../hello-src; echo "(exit $?)"
echo
echo '$ make clean && make VERSION=2.0'
make clean && make VERSION=2.0; echo "(exit $?)"
echo
echo '$ make install VERSION=2.0 PREFIX=../opt/stow/hello-2.0'
make install VERSION=2.0 PREFIX=../opt/stow/hello-2.0; echo "(exit $?)"
echo
echo '$ cd ../opt/stow'
cd ../opt/stow; echo "(exit $?)"
echo
echo '$ stow hello-2.0'
stow hello-2.0; echo "(exit $?)"
echo
echo '$ stow -D hello-1.0'
stow -D hello-1.0; echo "(exit $?)"
echo
echo '$ stow hello-2.0'
stow hello-2.0; echo "(exit $?)"
echo
echo '$ ../bin/hello'
../bin/hello; echo "(exit $?)"
echo
echo '$ cat ../share/hello/message.txt'
cat ../share/hello/message.txt; echo "(exit $?)"
echo
echo '$ stow -D hello-2.0'
stow -D hello-2.0; echo "(exit $?)"
echo
echo '$ ls -la ..'
ls -la ..; echo "(exit $?)"
echo
echo '$ rm -r hello-1.0 hello-2.0'
rm -r hello-1.0 hello-2.0; echo "(exit $?)"
echo
echo '$ find .. -mindepth 1 | sort'
find .. -mindepth 1 | sort; echo "(exit $?)"
} > "$TR/t10-software-tree.txt" 2>&1

# ---------------------------------------------------------------- t11
{
export HOME=$WORK/home
echo '$ printf ... > "$HOME/.stowrc"'
printf '%s\n' "--dir=$WORK/home/dotfiles" "--target=$WORK/home" \
  > "$HOME/.stowrc"; echo "(exit $?)"
echo
echo '$ cat "$HOME/.stowrc"'
cat "$HOME/.stowrc"; echo "(exit $?)"
echo
echo '$ cd "$WORK"'
cd "$WORK"; echo "(exit $?)"
echo
echo '$ stow -n -v scripts'
stow -n -v scripts; echo "(exit $?)"
echo
echo '$ ls "$HOME/bin"'
ls "$HOME/bin"; echo "(exit $?)"
echo
echo '$ stow scripts'
stow scripts; echo "(exit $?)"
echo
echo '$ ls -la "$HOME/bin"'
ls -la "$HOME/bin"; echo "(exit $?)"
echo
echo '$ "$HOME/bin/greet"'
"$HOME/bin/greet"; echo "(exit $?)"
} > "$TR/t11-stowrc-and-simulate.txt" 2>&1

# ---------------------------------------------------------------- t12
mkdir -p "$WORK/t12/home"
"$LAB/make-fixture.sh" "$WORK/t12/dotfiles" >/dev/null
{
export HOME=$WORK/t12/home
cd "$WORK/t12"
echo '$ stow -d dotfiles -t home nosuchpackage'
stow -d dotfiles -t home nosuchpackage; echo "(exit $?)"
echo
echo '$ stow -d dotfiles -t home editor'
stow -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ rm dotfiles/editor/.vimrc'
rm dotfiles/editor/.vimrc; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
echo
echo '$ cat home/.vimrc'
cat home/.vimrc; echo "(exit $?)"
echo
echo '$ chkstow -t home'
chkstow -t home; echo "(exit $?)"
echo
echo '$ stow -D -d dotfiles -t home editor'
stow -D -d dotfiles -t home editor; echo "(exit $?)"
echo
echo '$ ls -la home'
ls -la home; echo "(exit $?)"
} > "$TR/t12-errors-and-dangling-links.txt" 2>&1

# ---------------------------------------------------------------- t13
mkdir -p "$WORK/t13/home/dotfiles/plainpkg"
printf '%s\n' '# bashrc kept in the repo without a leading dot.' \
  > "$WORK/t13/home/dotfiles/plainpkg/dot-bashrc"
printf '%s\n' 'a setting' \
  > "$WORK/t13/home/dotfiles/plainpkg/dot-config-note.txt"
{
export HOME=$WORK/t13/home
echo '$ cd "$HOME/dotfiles"'
cd "$HOME/dotfiles"; echo "(exit $?)"
echo
echo '$ find plainpkg -type f | sort'
find plainpkg -type f | sort; echo "(exit $?)"
echo
echo '$ stow plainpkg'
stow plainpkg; echo "(exit $?)"
echo
echo '$ ls -la "$HOME"'
ls -la "$HOME"; echo "(exit $?)"
echo
echo '$ stow -D plainpkg'
stow -D plainpkg; echo "(exit $?)"
echo
echo '$ stow --dotfiles plainpkg'
stow --dotfiles plainpkg; echo "(exit $?)"
echo
echo '$ ls -la "$HOME"'
ls -la "$HOME"; echo "(exit $?)"
echo
echo '$ readlink "$HOME/.bashrc"'
readlink "$HOME/.bashrc"; echo "(exit $?)"
} > "$TR/t13-dotfiles-flag.txt" 2>&1

export HOME=$REAL_HOME
echo "lab complete: transcripts in $TR"
ls "$TR"
