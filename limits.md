# Limits

What Stow cannot do, stated plainly.
Most of these the lab met directly; the
rest are marked as the manual's word.

**No decisions.** Stow cannot vary a
file by machine, by operating system,
or by anything else. The package's
contents are the target's contents,
identically, everywhere. Per-machine
difference is achieved only by stowing
different packages (chapter 11), and
two packages claiming the same path is
a conflict, not a merge (chapter 7).
There is no templating, no variable
substitution, no conditional anything.

**No secrets.** Nothing is encrypted,
hidden, or access-controlled. A stowed
file has exactly the exposure of the
package folder it lives in, and chapter
1's line bears repeating here: a secret
in a published package is a published
secret. Stow also preserves the
package's file permissions — it does
not tighten a carelessly readable file
for you.

**Links are all it makes.** Stow never
copies. Every consequence of chapter
2's model applies: the target path is
useless without the package (delete or
move the stow directory and every link
dangles); a program that refuses to
follow symlinks, or that resolves a
link and then writes beside the *real*
file expecting the target's neighbours,
will misbehave in ways Stow cannot
help with; and configuration that must
live on a filesystem without symlinks
— some network mounts, and Windows
without developer privileges, per the
manual's portability notes — is simply
outside the tool's world.

**The folded-folder trap.** When Stow
folds a whole folder into one link
(chapter 6), any file a program or a
person creates inside that folder in
the target is created *inside the
package* — silently joining the
package, to be stowed everywhere the
package goes and versioned if the
package is. The lab's `.config` link
means a new file written to
`~/.config/anything` is a new file in
`dotfiles/editor/.config/anything`.
The defence is knowing it happens:
unfold by stowing a second package
that shares the folder, or accept the
package as the folder's true home.

**Stow sees only its own actions.**
Files that appear in the target by any
other route — a program's own installer,
your editor saving a new settings file
beside the stowed one — are invisible
to it until the day they collide as a
conflict. `chkstow` finds links whose
files vanished; nothing finds files
that were never stow's. A target is
tidy exactly to the extent that Stow
is the only one writing to the paths
it manages.

**One version stowed at a time.**
Chapter 10's tree can hold every
version you ever built, but the prefix
wears exactly one. The conflict that
enforces this is a feature — no silent
half-upgrades — but genuine
side-by-side running of two versions
is another arrangement's job.

**Removal is links only, and packages
are your problem.** Unstow removes
links; the package folder remains,
forever, until you delete it by hand.
Stow has no notion of garbage
collecting versions, pruning old
packages, or noticing that nobody has
stowed `editor` in a year.

**Age shows at the edges.** Stow is
finished software in the good sense —
the model has not needed to change in
decades — and in the limiting sense:
conflict messages are terse and vary a
little between the 2.3 series the lab
ran and the current 2.4 series; there
is no progress display, no colour, no
undo log. What it reports, it reports
in the lines chapters 7 and 14 teach
you to read, and nothing more is
coming. For most readers that is the
bargain working as intended.
