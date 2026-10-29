# Ignore Rules

**Outcome: you can keep a package's
housekeeping files — its README, its
version-control folder, your scratch
notes — out of the target, and you know
the one rule that surprises everyone:
an ignore file replaces the built-in
list, it does not add to it.**

A package is a working folder, and
working folders collect files that are
not configuration: a README for the
human reader, the `.git` folder if the
package lives in version control,
editor backup files, a note you wrote
to yourself. Stowed plainly, all of it
would be linked into the target.
**Ignore rules** are how a file is in
the package but never stowed.

## The built-in list

Stow already ignores a standard set,
aimed at version-control internals and
editor litter. The lab's `editor`
package was given a `.git` folder, a
backup file `extra~`, a `README.md`,
and two ordinary extra files,
`notes.txt` and `secret.txt`, and
stowed with no ignore file anywhere.
The target received the ordinary files
— and only them:

```text
$ ls -la home
.config   -> ../dotfiles/editor/.config
.vimrc    -> ../dotfiles/editor/.vimrc
notes.txt -> ../dotfiles/editor/notes.txt
secret.txt -> ../dotfiles/editor/secret.txt
```

(Transcript
`stow-lab/transcripts/t08-ignore-rules.txt`.)
No `.git`, no `extra~`, no `README.md`.
The built-in list (read from the
program itself, and quoted in full in
the lab's notes) covers: the version
control folders and files `RCS`, `CVS`,
`.svn`, `.hg`, `.git` and friends,
backup and autosave files ending in `~`
or wrapped in `#`, and — anchored at
the package's root — `README.*`,
`LICENSE.*` and `COPYING`. A package
may document itself and carry its
history without any of it leaking into
the target.

## Your own list: `.stow-local-ignore`

To ignore more, put a file named
`.stow-local-ignore` in the package
folder. Each line is a regular
expression matched against a file's
path *inside the package*; `#` starts a
comment. The lab added one ignoring its
three housekeeping files:

```text
README\.md
notes\.txt
extra~
```

Stowed again, `notes.txt` stayed home
with the others. (The ignore file
itself is never stowed — Stow always
excludes it.)

Then the surprise, and it is the reason
this chapter exists. In that same
listing, **`.git` was back** — linked
into the target like any other folder:

```text
.git -> ../dotfiles/editor/.git
```

**An ignore file replaces the built-in
list entirely; it does not extend it.**
The rule (the manual's, and the lab's
transcripts prove it twice over) is a
chain of first-found-wins: if the
package has a `.stow-local-ignore`,
that file alone is the list. Else, if
your home folder has a
`.stow-global-ignore`, that file alone
is the list — the lab used one holding
a single pattern, `secret\.txt`, and
watched `README.md`, `extra~` and
`.git` *all* come back while
`secret.txt` was skipped. Only when
neither file exists does the built-in
list apply.

The habit that follows: **when you
write a local ignore file, start it
with the built-in lines you cannot
live without** — above all `\.git` if
the package is version-controlled —
then add your own. The lab's repaired
file:

```text
\.git
README\.md
notes\.txt
extra~
```

Stowed with that file, the target held
the configuration and the one ordinary
file no rule had claimed — `.vimrc`,
`.config`, `secret.txt` — and none of
the housekeeping.

## One command only: `--ignore`

For a single run, `--ignore=PATTERN`
skips matching files without any file
being written:

```text
$ stow --ignore=secret\.txt -d dotfiles -t home editor
```

It is per-command and it evaporates:
the lab's next plain stow linked
`secret.txt` again, which is the
difference between the two tools — the
file for lasting rules, the option for
one occasion. (`--ignore` *adds* to
whatever list is in force; it does not
trigger the replacement above.)

## The check

After any change to ignore rules,
restow the package and list the target,
asking of every line: *should this be
here?* The target should name only
files a program will actually read.
Everything else is the package's
private business, and now stays there.
