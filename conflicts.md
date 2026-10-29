# Conflicts — When Stow Says No

**Outcome: you have seen Stow refuse,
you can read its refusal line by line,
and you know the refusal is total —
when a conflict exists, nothing is
linked at all.**

A **conflict** is any place where
stowing would have to displace something
already in the target that Stow does not
own: a real file you wrote by hand, a
link pointing somewhere else, a file
another package got there first. Stow's
rule is absolute and it is the tool's
best quality: **it never overwrites, and
it never does half a job.** It checks
the whole package first, reports every
conflict it found, and changes nothing.

## The refusal, for real

The lab set up a scratch home containing
one real, hand-written `.vimrc`, then
tried to stow the `editor` package —
which has its own `.vimrc` — into it:

```text
$ stow -d dotfiles -t home editor
WARNING! stowing editor would cause conflicts:
  * existing target is neither a link nor a directory: .vimrc
All operations aborted.
(exit 1)
```

(Transcript
`stow-lab/transcripts/t06-conflict.txt`.)

Read the middle line word by word,
because Stow's messages are terse and
each kind says something different:

- **"existing target is neither a link
  nor a directory"** — at that path sits
  a real file (or something else Stow
  cannot merge). This is the commonest
  conflict: you have a file, the package
  has the same file, and Stow will not
  choose between them.
- **"existing target is stowed to a
  different package"** — the path is a
  link, but it belongs to another
  package. Chapter 10 produces exactly
  this, trying to install a program's
  version 2.0 over its stowed 1.0:

  ```text
  * existing target is stowed to a different package: bin/hello => ../stow/hello-1.0/bin/hello
  ```

  The `=>` shows where the existing link
  points, so you can see *which* package
  is in the way.
- **"existing target is not owned by
  stow"** is the wording other Stow
  versions use for a link pointing
  outside any package — same meaning:
  something is there, and it is not
  Stow's to move.

Then the two lines that frame every
refusal: the warning names the package
and says *would* — the operation is
hypothetical until it is clean — and
**"All operations aborted"** is literal.
The lab's listing after the refusal
shows the hand-written `.vimrc`
untouched and `.config` — which the
package also contained, and which had
no conflict at all — *not linked*.
Clean parts of the package are not
stowed as a consolation prize. One
conflict stops everything.

## The check you run from here

When Stow refuses, the message *is* the
work list. For each line, decide about
that one path:

- A real file you want to *keep* and
  make the package's version? That is
  adoption — the file moves into the
  package and the link takes its place.
  Chapter 8, next, and it has a sharp
  edge the lab demonstrates.
- A real file you want to *keep as it
  is*, with the package's version
  ignored? Remove the file from the
  package, or ignore it (chapter 9).
- A link to another package? Unstow
  that package first, or accept its
  version. This is the version-swap
  dance of chapter 10.

And the rehearsal habit from chapter 5
applies at full strength: conflict
messages also appear in simulation
mode, so `stow -n PACKAGE` tells you
everything in this chapter's output
*before* anything real is attempted.
