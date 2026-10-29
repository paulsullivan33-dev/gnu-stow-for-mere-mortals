# Troubleshooting

The failures the lab met for real, in
roughly the order a new user meets
them. Transcripts:
`stow-lab/transcripts/t12-errors-and-dangling-links.txt`
unless another is named.

## "The stow directory ... does not contain package ..."

```text
stow: ERROR: The stow directory ../dotfiles does not contain package nosuchpackage
(exit 2)
```

You named a package that is not a
folder inside the stow directory Stow
is looking at. Two usual causes: a typo,
or — far commoner — you are standing
somewhere else, so the "stow directory"
(default: where you stand) is not the
one you think. The path in the message
is Stow telling you which directory it
searched; believe it. Fix the standing
place, or name the tree with `-d`.

## "WARNING! stowing ... would cause conflicts"

Not a malfunction — chapter 7's refusal,
working as designed. Read each starred
line as a work item: real file in the
way (adopt it, chapter 8, or move it
aside), or a link owned by another
package (unstow that one first).
Remember the refusal is total: nothing
at all was linked, including the parts
with no conflict, so there is no
half-state to clean up — just the
decision to make.

## It exited 0 — and nothing appeared

Silence is success's costume in Stow,
so check the target before assuming
failure. If the target truly has
nothing new, the usual suspects:

- **You stowed into the parent of the
  wrong folder.** The default target is
  the stow directory's parent; if your
  `dotfiles` lives in `~/projects`, your
  files were linked into `~/projects`,
  most likely quite successfully.
  `find ~/projects -type l` will confess.
  Name `-d` and `-t` explicitly
  (chapter 5).
- **Everything matched the ignore
  list.** A package of READMEs and
  backups stows to nothing, correctly
  (chapter 9). `stow -n -v PACKAGE`
  narrates what would happen and what
  is skipped.
- **You are looking at a link's
  contents, not a missing file.** A
  folded folder (chapter 6) means
  `~/.config` *is* the package's folder;
  `ls` *inside* it shows the files.

## The link is there but the file "does not exist"

```text
$ cat home/.vimrc
cat: home/.vimrc: No such file or directory
```

A **dangling link**: `ls -la` shows the
link, `readlink` shows its target, and
the target file is gone — deleted or
renamed inside the package after
stowing. The lab made one by deleting
the package's `.vimrc` under a stowed
home. Find all of them at once with the
companion tool:

```text
$ chkstow -t home
Bogus link: home/.vimrc
```

Then repair by intent: restore the
file in the package, or restow the
package (`stow -R PACKAGE`), or unstow
it — the lab verified that unstowing
removes dangling links along with the
healthy ones, leaving the target clean.

## The wrong file's contents are showing

You edited the file in the target and
the package "changed by itself" — or
the reverse complaint. There is only
one file; the link is not a copy
(chapter 2). Editing either path edits
the package's file. If you wanted an
independent copy in the target, Stow
is the wrong tool for that path:
remove it from the package (or ignore
it), unstow, and put a real file there.

## A folder in the target became a link (or stopped being one)

Folding and unfolding (chapters 2 and
6): a folder wholly owned by one
package is a single link; shared, it is
a real folder of links. Both shapes are
healthy. The case worth a second look
is a program writing *new* files into a
folded folder — they land inside the
package (chapter 13's trap). If a
package should never receive files,
give the folder a second owner or keep
that subtree out of the package.

## Conflicts that "make no sense"

Work the message literally before
suspecting the tool. `readlink` the
named target path: a link pointing
somewhere unexpected usually means an
earlier experiment — a hand-made link,
a stow into this target from a
different tree, a package renamed in
the tree (its old links now point at a
path that no longer owns them). Unstow
by the package's *current* name after
re-stowing from the right tree, or
remove the stray link by hand and
stow again. Stow forgives quickly once
the target tells the truth.
