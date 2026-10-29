# What Stow Is

**Outcome: a clear picture of the job
Stow does — keeping related files in one
tidy folder and making them appear where
programs expect them — before you install
anything.**

Everyone who uses a computer for long
collects small files that matter: an
editor's settings, a shell's startup
file, a handful of personal scripts.
Together they are called **dotfiles**,
because most of their names begin with a
dot. They start life scattered. The
editor looks for its settings in your
home folder. The shell reads its file
from the same place. Your scripts need
to sit in a folder on your path. Moving
to a new machine means hunting down each
one; editing one means remembering where
the real copy lives; and backing them up
means copying a dozen loose files out of
a home folder full of everything else.

**GNU Stow turns that scatter into one
folder.** You keep each group of related
files in its own **package**: a folder
whose inside is laid out exactly like
the place the files belong. The editor
package holds a `.vimrc` and a folder
`.config/nvim/` with a file inside, just
as they should appear in your home
folder. Then you run one command —
`stow editor` — and Stow fills your home
folder with **symbolic links**: small
pointer files that say "the real file
lives over there." The editor opens its
settings and follows the pointer without
knowing anything happened. The real
files never leave the package.

A symbolic link (symlink for short) is
worth one sentence of its own, because
the whole tool stands on it: a symlink
is a file whose entire content is a
path. Open it and the system quietly
hands you the file at the end of the
path instead. Edit it and you edit the
real file. Delete the link and the real
file is untouched.

Why bother with pointers instead of just
copying the files into place? Three
reasons, and they are the reasons this
tool has survived since 1993:

- **One home for each thing.** The
  package is the only copy. There is no
  "which of these is current?" — the
  file in the package is current,
  because it is the only one.
- **Reversible in one command.**
  `stow -D editor` (unstow) removes
  every link the package created and
  nothing else. Trying a new editor
  setup, or abandoning one, is tidy.
- **The folder is a thing you can
  keep.** A folder of packages can live
  in version control — this series has a
  guide to Git — so your settings gain a
  history, and a new machine is one
  clone and a few `stow` commands away
  from feeling like home.

One warning belongs this early, and it
is the guide's ethics line: **a link
does not hide anything.** A file in a
package is as readable as any other
file, and if the package folder is
published — pushed to a public Git
repository, say — every file in it is
published too, in full. Passwords, keys
and tokens never belong in a stowed
package. Keep secrets in a tool built
for them; Stow is built for settings.

## The second job: software you build

Stow's full name in its own manual is a
*symlink farm manager*, and dotfiles are
only its most famous farm. The older
job, the one it was written for, is
managing software you compile yourself.
Build a program, install it into its own
folder — `hello-1.0` — inside a **stow
tree**, and Stow links its `bin`,
`lib` and `share` folders into the
shared prefix, traditionally
`/usr/local`. Version 2.0 gets its own
folder beside the first. Swapping
versions is unstow one, stow the other;
removing the program entirely is one
unstow and deleting its folder, with no
files forgotten in shared directories.
Chapter 10 does the whole dance with a
tiny program built in the lab.

## What it is not

Stow is not a configuration *language*.
It cannot fill in your name in one file
and a different name in another, cannot
choose settings by which machine you are
on, and cannot encrypt anything — tools
that template and decide exist, and
chapter 12 meets the biggest of them,
Chezmoi. Stow is not a backup tool: it
protects nothing, it only organises.
And it is not an installer in the
package-manager sense: it does not know
what a program needs, does not fetch
anything, and does not check versions.
It does one thing — maintain a forest of
symlinks so that files appear where they
are expected — and the rest of this
guide is that one thing, done carefully.

## Who it is for

The person with dotfiles on more than
one machine. The person who builds the
occasional program from source and wants
it removable. The person who has been
copying their `.bashrc` around with a
USB stick and suspects there is a better
way. There is, and it is thirty years
old, one small Perl program, and the
subject of the next twelve chapters.
