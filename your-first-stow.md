# Your First Stow

**Outcome: one package stowed into a
home folder — links in place, the real
files still in the package — checked
three ways.** The lab did this in a
scratch home folder so nothing real was
at risk; the commands are identical in
your real home, and the fixture is in
`stow-lab/` if you want the same files.

## The fixture

The lab's stow directory is a folder
called `dotfiles` in the home folder,
holding the three packages from
chapter 2. The editor package is the
only one this chapter needs:

```text
$ find dotfiles -type f | sort
dotfiles/editor/.config/nvim/init.vim
dotfiles/editor/.vimrc
dotfiles/scripts/bin/greet
dotfiles/scripts/bin/today
dotfiles/shell/.bashrc
dotfiles/shell/.config/bash/extra.sh
```

Read the layout once more, because it is
the whole idea: inside `editor/`, the
files sit exactly where they belong in
the home folder — `.vimrc` at the top,
`init.vim` down the path
`.config/nvim/`. Whatever folder the
package mirrors, that folder is the
target.

## The command

Stand in the stow directory and name the
package:

```bash
cd ~/dotfiles
stow editor
```

Stow prints nothing at all when it
succeeds. That silence is normal — this
is an old Unix tool, and success is
quiet — which is exactly why this guide
checks everything with `ls` afterwards
instead of trusting the quiet.

## The check — three looks

First look: the home folder now holds
two new entries, and both are links —
the `l` at the start of each line, and
the `->` showing where each points:

```text
$ ls -la
lrwxrwxrwx 1 .config -> dotfiles/editor/.config
lrwxrwxrwx 1 .vimrc  -> dotfiles/editor/.vimrc
```

(Owner, sizes and dates trimmed; the
full listing is transcript
`stow-lab/transcripts/t01-first-stow.txt`.)

Second look: ask the links themselves.
`readlink` prints the path each link
contains:

```text
$ readlink .vimrc .config
dotfiles/editor/.vimrc
dotfiles/editor/.config
```

Third look: use the file as a program
would. `cat .vimrc` follows the link and
prints the package's file — the editor
will do the same when it loads its
configuration.

Notice what is *not* there. The links
are exactly two: one for `.vimrc`, and
one for `.config` as a whole. There is
no link for `nvim` or for `init.vim`
separately — `find . -type l` lists just
the two. That is **folding**, chapter
2's rule in the flesh: `.config` did not
exist in the target, so Stow linked the
package's whole `.config` folder in one
piece, and `init.vim` rides inside it.
Chapter 6 puts a second package under
`.config` and watches Stow split that
link open.

One more thing to carry forward: the
link targets are *relative* —
`dotfiles/editor/.vimrc`, not an absolute
path. Stow writes links that stay right
if the whole home folder is moved as a
unit. It also means a link only makes
sense from where it sits, which is why
`readlink` output is read relative to
the link's own folder, a point chapter
14 needs when a link looks wrong.
