# Glossary

**Adopt** — `stow --adopt`: when a real
file in the target blocks a package,
move the file into the package
(replacing the package's copy) and stow
as usual. Chapter 8.

**chkstow** — the companion checker
shipped with Stow. Walks a target and
reports dangling links that point into
a stow tree.

**Conflict** — a target path that
stowing would have to displace and
that Stow does not own: a real file, a
foreign link, another package's link.
Any conflict aborts the whole
operation; nothing is linked.
Chapter 7.

**Dangling link** — a symlink whose
target file no longer exists. `ls`
shows it, opening it fails. `chkstow`
finds them.

**Dotfiles** — the collective name for
a user's configuration files, most of
which begin with a dot and are hidden
from ordinary listings.

**Folding** — Stow's habit of linking
a whole folder with a single symlink
when the target has no such folder and
one package owns everything under it.
Two packages sharing a folder unfold
it into a real folder of links;
removing the second can refold it.
Chapter 6.

**Ignore list** — the set of patterns
for paths inside a package that Stow
will not stow. Built-in by default; a
`.stow-local-ignore` file in the
package, or a `.stow-global-ignore` in
the home folder, replaces it entirely
— first found wins. Chapter 9.

**Package** — one folder inside the
stow directory, holding files laid out
exactly as they should appear in the
target. The unit of stowing.

**Restow** — `stow -R`: unstow then
stow again. Picks up files added to or
removed from a package since it was
stowed.

**Simulation mode** — `stow -n` (long
form `--no`): plan everything, print
the plan with `-v`, change nothing.

**Stow directory** — the folder holding
your packages. Defaults to the folder
you are standing in; set with `-d`.

**`.stowrc`** — a file of default
options, one per line, read from the
home folder and the stow directory.
Command-line options override it.

**Symlink (symbolic link)** — a file
whose content is a path to another
file. Opening it opens the other file;
Stow's links are relative, so they are
read from the link's own folder.

**Target directory** — the folder the
links are created in: your home for
dotfiles, a prefix like `/usr/local`
for built software. Defaults to the
stow directory's parent; set with `-t`.

**Unstow** — `stow -D` (long form
`--delete`): remove every link a
package owns from the target. Never
deletes a real file.
