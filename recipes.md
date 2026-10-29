# Recipes

Short jobs, each built only from pieces
the earlier chapters verified. The
lab's fixture — `stow-lab/fixture/` —
is the starting material for the first
several.

## Lay out a dotfiles folder from zero

The shape the whole guide stands on
(chapters 4–6). One folder, one package
per topic, files laid out as they should
appear at home:

```text
dotfiles/
  editor/    .vimrc, .config/nvim/init.vim
  shell/     .bashrc, .config/bash/extra.sh
  scripts/   bin/greet, bin/today
```

Then, standing in it: `stow editor
shell scripts`. Put the folder in
version control and it becomes the
portable, historical record of your
setup — this series' Git guide is the
companion. Remember chapter 1's line:
everything in the folder is as public
as the repository is. Secrets never go
in.

## Rehearse every change with `-n -v`

Simulation mode plans and changes
nothing (chapter 2, transcript t11):

```bash
stow -n -v scripts
```

```text
LINK: bin => dotfiles/scripts/bin
WARNING: in simulation mode so not modifying filesystem.
```

Read the plan, then run the same
command without `-n`. The habit is
worth most exactly where the stakes
are: a new machine, a borrowed target,
an `--adopt`.

## Shrink the daily command with `.stowrc`

If your stow directory is not inside
your home, the `-d`/`-t` pair gets old.
A `.stowrc` in your home folder holds
the defaults — two lines, your own two
paths written in full (the lab's file,
with its scratch paths, is transcript
t11):

```text
--dir=/path/to/your/dotfiles
--target=/path/to/your/home
```

After that, `stow editor` works from
any directory on the machine. Options
on the command line still override the
file, and a `.stowrc` in the stow
directory itself is read too. Write
paths in full — the file is not a
shell, and nothing in it is expanded.

## Keep hidden files visible in the repo

Some people keep dotfiles in version
control without the leading dots, so
the files list readably. Name files
`dot-` instead of `.` inside packages —
`dot-bashrc`, `dot-config/` — and stow
with the flag that translates:

```bash
stow --dotfiles shell
```

The lab verified the translation both
ways (transcript
`stow-lab/transcripts/t13-dotfiles-flag.txt`):
without the flag, `dot-bashrc` links
into the target under that literal
name; with it, the link is `.bashrc`
pointing at the package's `dot-bashrc`.
Every path component is translated, so
`dot-config/nvim/init.vim` becomes
`.config/nvim/init.vim`.

## Bring an existing machine under Stow

The first-day recipe, from chapters 7
and 8. For each group of files:

1. Make the package folder and copy —
   do not yet move — nothing.
2. `stow -n PACKAGE` and read the
   conflicts: that list *is* your
   existing files, enumerated for free.
3. For each, decide: adopt it
   (`stow --adopt PACKAGE`, the target
   file becomes the package's) or set
   it aside and let the package's
   version win.
4. Stow plainly once the rehearsal is
   clean.

## Audit a target with `chkstow`

Stow ships a small companion, `chkstow`,
that walks a target and reports links
pointing into a stow tree whose files
are gone — the dangling links of
chapter 14:

```bash
chkstow -t ~
```

It names each offender by its full
path — in the lab, against a scratch
target, the answer was:

```text
Bogus link: home/.vimrc
```

(Transcript t12.) Run it after tidying
packages by hand; a restow or unstow of
the named package clears what it finds.

## One package per machine, one shared

Machines differ. Keep a `common`
package for what is true everywhere,
and a small package per machine for
what is not — `laptop`, `desktop` —
and stow `common` plus the machine's
own on each. There is no machinery for
this, and that is the point: the
organisation lives in folder names,
and any file two packages both claim
announces itself as a chapter 7
conflict at stow time, before it can
do harm.
