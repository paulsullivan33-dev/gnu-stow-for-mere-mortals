# Adopting Files You Already Have

**Outcome: a file that already exists in
the target — the classic blocker from
chapter 7 — is brought into the package
with `--adopt`, and you know the price:
the existing file's contents replace
the package's copy.**

Nobody starts with an empty home folder.
You already *have* a `.bashrc`; that is
why chapter 7's conflict is the normal
first experience of Stow, not an edge
case. `--adopt` is Stow's answer for
exactly that moment. Where plain stow
refuses because a real file is in the
way, `stow --adopt` does three things
in one motion:

1. **Moves** the existing file out of
   the target and into the package, at
   the path the package expects.
2. Thereby **replaces** the package's
   own file at that path, if it had one.
3. Stows the package as usual, so the
   target now holds a link to the (just
   moved) file.

## The lab's run

Same setup as chapter 7: a scratch home
with a hand-written `.vimrc`, and an
`editor` package whose `.vimrc` says
something different:

```text
$ stow --adopt -d dotfiles -t home editor
(exit 0)
```

The refusal is gone, and the target
looks stowed:

```text
$ ls -la home
.config -> ../dotfiles/editor/.config
.vimrc  -> ../dotfiles/editor/.vimrc
```

Now the check that reveals the price.
Whose words are in the file, the
package's original or the hand-written
one? The package file's contents are
the *hand-written* ones:

```text
$ cat dotfiles/editor/.vimrc
" My own vimrc, written by hand.
set nocompatible
```

(Transcript
`stow-lab/transcripts/t07-adopt.txt`.)
The lab's fixture `.vimrc` — the little
sample configuration from chapter 4 —
is gone, overwritten by the adopted
file. That is not a bug; it is the
definition of the operation. The file
in the target was the one in use, so it
is treated as the truth, and the
package absorbs it.

## Using adoption safely

- **Adopt is the right tool** when the
  existing file is the one you actually
  use and the package is new — the
  standard first-day-of-Stow situation.
  Your real `.bashrc` becomes the
  package's `.bashrc`, and life goes on.
- **Adopt is the wrong tool** when the
  package's version is the one you
  want — a fresh clone of a dotfiles
  repository onto a machine with stock
  files, say. Then let the conflict
  stand, move the target's file aside
  by hand (rename it to
  `.bashrc.before-stow`), and stow
  plainly. You keep both, and you chose
  consciously.
- **If the package lives in version
  control, adoption is easy to undo**:
  the adopted file shows up as a change
  to the package file, and your history
  can take you back. Adopting into a
  package with no history destroys the
  old package file for good. The lab's
  fixture had its pristine copy kept
  apart (`stow-lab/fixture/`), which is
  why the loss above is a demonstration
  and not an accident.
