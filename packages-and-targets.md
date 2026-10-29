# Packages and Targets

**Outcome: you can stow any package
into any target — not just dotfiles
into home — by naming the two folders
out loud, and you know how to check
where a link was pointed.**

Chapter 4 got away with no options
because the layout was the classic one:
stand in `~/dotfiles`, target defaults
to the parent, done. The moment your
stow directory lives anywhere else — a
`dotfiles` checkout in a projects
folder, a software tree under `/opt`, a
test folder — the defaults point at the
wrong parent, and links land somewhere
you did not mean. The defence is a
habit, not a trick: **say both folders,
every time it is not the classic
layout.**

```bash
stow --dir=/path/to/packages --target=/path/to/target PACKAGE
```

Short forms `-d` and `-t` do the same
job. Both paths may be relative — Stow
works them out from where you stand, and
writes its links relative to the target
either way.

## The lab's proof

The lab built a scenario folder holding
a `dotfiles/` tree beside an empty
folder called `elsewhere/`, and stowed
two packages into the non-home target:

```text
$ stow -d dotfiles -t elsewhere editor shell
(exit 0)

$ ls -la elsewhere
.bashrc -> ../dotfiles/shell/.bashrc
.config
.vimrc  -> ../dotfiles/editor/.vimrc
```

(Transcript
`stow-lab/transcripts/t09-other-targets.txt`.)
Nothing about the packages changed —
the same `editor` and `shell` that went
into a home folder in chapter 4 went
here instead, because the target is a
decision made per command, not a
property of the package. The links point
*up and over* (`../dotfiles/...`),
relative to the target they sit in.

Unstowing is the mirror image, and it
needs the same two options — Stow must
be told which target to clean:

```text
$ stow -D -d dotfiles -t elsewhere editor shell
(exit 0)

$ ls -la elsewhere
total 0
```

An emptied target, with the packages
untouched in their tree. Chapter 7's
conflict and chapter 8's adoption both
happen in a scratch target set up
exactly this way — rehearsing on a
target that is not your home is the
single best habit this guide can give
you.

## Organising the packages themselves

A package is just a folder, so
organisation is foldercraft:

- **One package per tool or topic** is
  the natural grain — `editor`, `shell`,
  `scripts` — because stowing is per
  package: you install and remove at
  that grain.
- **Files shared by everything** go in a
  package of their own (a `common`
  package), stowed everywhere.
- **Packages mirror different depths.**
  A package may hold a top-level file
  (`.bashrc`), a deep file
  (`.config/nvim/init.vim`), or a whole
  tool folder (`bin/`). Depth costs
  nothing; the tree inside the package
  is simply the tree you want in the
  target.
- **The stow directory need not be one.**
  Two stow directories — say `dotfiles`
  for settings and a tree under `/opt`
  for built software — coexist without
  knowing about each other. Chapter 10
  builds the second kind.

The check for this whole chapter is one
question you can always answer with
`readlink`: *standing in the target,
where does this link point, and is that
the package I meant?* If yes, the
organisation is right, whatever it
looks like.
