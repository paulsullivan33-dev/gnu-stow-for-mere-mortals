# The Moving Parts

**Outcome: you can name the four things
every Stow command involves — the stow
directory, the package, the target, and
the links themselves — and you know the
one behaviour, folding, that explains
most surprises.**

Stow has very few parts. That is its
charm and its trap: with so little
machinery, every confusion comes from
one of four nouns or one behaviour.
This chapter names them all, using the
lab's fixture, which the next chapters
build for real.

## The stow directory

The **stow directory** is the folder
that holds your packages. For dotfiles
it is usually a folder called `dotfiles`
in your home directory. Stow assumes
the folder you are standing in is the
stow directory unless you tell it
otherwise with `--dir` (short `-d`).

## The package

A **package** is one folder inside the
stow directory, holding files laid out
exactly as they should appear in the
target. The lab's fixture has three:

```text
dotfiles/
  editor/
    .vimrc
    .config/nvim/init.vim
  shell/
    .bashrc
    .config/bash/extra.sh
  scripts/
    bin/greet
    bin/today
```

Read the `editor` package as a sentence:
"in the target there should be a file
`.vimrc`, and a file
`.config/nvim/init.vim`." The package
says nothing about where the target
*is*; that is a separate decision, which
is why the same package can be stowed
into your home today and into a test
folder tomorrow.

## The target directory

The **target directory** is where the
links are created — for dotfiles, your
home folder. Here is the default that
trips every beginner once: **if you do
not name a target, Stow uses the parent
folder of the stow directory.** Stand in
`~/dotfiles` and run `stow editor`, and
the target is `~` — which is exactly
right for dotfiles, and completely wrong
the day you keep your stow directory
somewhere else. `--target` (short `-t`)
names it explicitly. Chapter 5 makes a
habit of naming both folders out loud.

## The links, and folding

Stowing a package walks its tree and
mirrors it in the target with symlinks.
Files are linked one by one. Folders
are where it gets interesting, because
Stow would rather link a whole folder
than its contents when it can. This is
called **tree folding**:

- If the target has no `.config` at
  all, stowing `editor` creates
  `.config` in the target as a *single
  symlink* to the package's `.config`
  folder. The whole subtree rides on
  one link.
- Later, stowing `shell` — which also
  has files under `.config` — cannot
  share that link, because the link
  points into `editor`'s folder and
  `shell`'s files are not there. So
  Stow **unfolds**: it replaces the
  folder link with a real `.config`
  folder, links `nvim` from `editor`
  and `bash` from `shell` inside it,
  and carries on. Unstowing may **fold**
  a folder back into a single link when
  one package again owns everything
  under it.

Folding is not a cosmetic detail. It
decides what `ls -la` shows, why a
folder in your home is sometimes a link
and sometimes real, and why adding a
file by hand inside a folded folder
puts the file *inside the package* —
chapter 13 returns to that trap. The
lab demonstrates folding and unfolding
for real in chapter 6's transcript;
for now, hold the rule: **Stow links
the largest piece it can, and splits
the piece when two packages need to
share it.**

## The supporting cast

Three smaller parts appear in later
chapters:

- **The ignore list.** Some files in a
  package should never be linked — its
  own README, version-control internals
  like a `.git` folder, editor backup
  files. Stow carries a built-in ignore
  list, and a package can add its own in
  a file called `.stow-local-ignore`
  (chapter 9).
- **`.stowrc`.** A file in your home
  folder (or the stow directory) holding
  default options — your usual `--dir`
  and `--target` — so the daily command
  shrinks to `stow editor` anywhere
  (recipes, chapter 11). Command-line
  options still win over the file.
- **Simulation mode.** `--no` (short
  `-n`) makes Stow plan everything and
  change nothing, and `--verbose`
  narrates the plan. It is the seatbelt
  for every verb in chapter 6: run with
  `-n` first, read, then run for real.

## Which part holds what

| Question | The part that answers it |
| --- | --- |
| Where do the real files live? | The package, inside the stow directory |
| Where do programs find them? | The target, through symlinks |
| Why is this folder a link but that one real? | Folding — one package owns it, or two share it |
| Why did nothing appear where I expected? | The target defaulted to the stow directory's parent |
| Why was this file skipped? | The ignore list, built-in or `.stow-local-ignore` |
| Why did Stow refuse entirely? | A conflict in the target — chapter 7 |
