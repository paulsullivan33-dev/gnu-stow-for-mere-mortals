# Stow, Unstow, Restow

**Outcome: the three verbs, in full —
what each one does to the target, what
it leaves alone, and the unfolding that
happens when two packages share a
folder.** All three are one command
each, and all three were run for real
in the lab's scratch home.

## Stow: link a package in

`stow PACKAGE` (long form `stow -S
PACKAGE`) walks the package and mirrors
it in the target with links, folding
folders where it can (chapter 2). The
lab stowed the fixture's `scripts`
package, whose `bin/` folder shows
folding in its purest form — the target
had no `bin`, so `bin` itself arrived
as a single link:

```text
$ stow scripts
(exit 0)

$ ls -la "$HOME/bin"
bin -> dotfiles/scripts/bin
```

(Paths trimmed; transcript
`stow-lab/transcripts/t03-scripts-package.txt`.)

And because the target of a link is the
real thing, the programs simply work:

```text
$ greet
Hello from the scripts package.
```

Stowing a package that is already
stowed is a harmless no-op — Stow finds
its own links in place and does nothing.
That makes `stow` safe to run again
after you lose track of what is in,
which, once the packages multiply, you
will.

## Folding, unfolding, refolding

Chapter 4 ended with `.config` as one
folded link into the `editor` package.
Watch what the second package does to
it. The lab stowed `shell`, which also
keeps files under `.config`:

```text
$ stow shell
(exit 0)

$ ls -la "$HOME/.config"
bash -> ../dotfiles/shell/.config/bash
nvim -> ../dotfiles/editor/.config/nvim
```

`.config` itself is a real folder now —
Stow **unfolded** it, replacing the
single link with a directory holding one
link per package. Neither package lost
anything; the tree just changed shape
to be shared. The reverse also happens,
and the lab watched it: unstowing
`shell` again **refolded** `.config`
back into a single link into `editor`'s
folder, since one package once more
owned everything under it:

```text
$ stow -D shell
(exit 0)

$ readlink "$HOME/.config"
dotfiles/editor/.config
```

(Transcript
`stow-lab/transcripts/t02-folding-and-unfolding.txt`.)
You never ask for folding or unfolding;
it is the shape the link tree takes, and
knowing it exists is what keeps a folder
turning into a link (or back) from
looking like damage.

## Restow: pick up new files

Editing a file that is already stowed
needs no ceremony at all — the link
points at the package file, so the edit
*is* the change. The lab edited the
`greet` script inside its package, and
the command in the home folder printed
the new text immediately, no restow
involved (transcript t04).

What links cannot do is announce a file
that did not exist when the package was
stowed. The lab added a new file,
`.bash_aliases`, to the `shell` package:

```text
$ ls -l "$HOME/.bash_aliases"
ls: cannot access ... No such file or directory
```

**Restow** — `stow -R PACKAGE`, unstow
followed by stow — is the refresh:

```text
$ stow -R shell
(exit 0)

$ ls -l "$HOME/.bash_aliases"
.bash_aliases -> dotfiles/shell/.bash_aliases
```

Restow after every addition or removal
inside a package. It is also the fix
when a link tree has drifted — a file
deleted from a package leaves its link
dangling, and restowing the package
sweeps it away (chapter 14).

## Unstow: take a package out

`stow -D PACKAGE` (long form
`stow --delete`) removes the links that
belong to the package — all of them, and
nothing else. The lab unstowed all three
fixture packages from the scratch home,
which also held one hand-made file that
no package owned:

```text
$ stow -D scripts editor shell
(exit 0)

$ ls -la "$HOME"
.profile
dotfiles
```

(Transcript
`stow-lab/transcripts/t05-unstow.txt`.)
The hand-made `.profile` survived, the
packages themselves are untouched in
their tree — unstowing never deletes
real files — and folders Stow created
and folded are gone with their links.
This is the whole basis of Stow's
reversibility: a package can be tried
for a week and removed in one command,
leaving the target exactly as it was.
