# The Neighbours

Two neighbours matter for Stow, because
every Stow user meets both: the bigger
tool that does Stow's job with opinions
added, and the hand method Stow replaced.
These are characterisations, not
benchmarks; the lab ran Stow only, and
Chezmoi has a full guide of its own in
this series.

## Chezmoi: the dotfile manager with a memory

Chezmoi manages dotfiles the way a
database manages records: it keeps a
*source state* — files named with
prefixes that encode permissions,
privacy and templating — and applies it
to your home folder as real files, not
links. Where Stow's package says "this
file, here", a Chezmoi source file can
say "this file, here, with *this* line
different on the laptop, and don't
install it at all on the work machine,
and keep that one encrypted."

The differences that decide between
them:

- **Copies versus links.** Chezmoi
  writes real files into the target and
  re-applies them when the source
  changes; you run `chezmoi apply` to
  propagate an edit. Stow's links make
  the package file and the target file
  the same file, so edits are live in
  both directions with no apply step —
  and an edit made through the target
  is silently an edit to the package.
- **Decisions versus layout.** Chezmoi
  templates, encrypts, prompts, fetches
  remote pieces, and knows about
  password managers. Stow knows none of
  that: chapter 13 lists the absences.
  If one file must differ per machine,
  Stow's only answer is separate
  packages; Chezmoi's answer is a
  template line.
- **Cost of entry.** Chezmoi asks you
  to learn its source-state naming and
  its workflow. Stow asks you to learn
  four nouns and three verbs (chapters
  2 and 6) — for plain settings that
  are the same everywhere, it is
  honestly all you need.

The *Chezmoi for Mere Mortals* guide in
this series teaches that tool properly.
The short version: reach for Chezmoi
when your dotfiles need to *decide*
things; reach for Stow when they just
need to *be* somewhere.

## Plain symlinks by hand: the method underneath

Everything Stow does can be done with
`ln -s` and patience, and for two or
three files it often should be:

```bash
ln -s ~/dotfiles/editor/.vimrc ~/.vimrc
```

No tool to install, nothing to learn,
and the link is right there. The costs
appear with scale and time:

- **Bookkeeping is yours.** Which links
  exist, which package each belongs to,
  which are stale — a hand-rolled setup
  keeps that in a script or in your
  head. Stow derives it from the
  package tree, always current by
  construction.
- **Removal is yours.** Unlinking one
  tool's files means finding them;
  missing one leaves litter. `stow -D`
  is one command, and the lab in
  chapter 6 watched it leave a target
  spotless.
- **Conflicts are silent.** `ln -s`
  onto an existing path fails with a
  bare "File exists", or worse, with
  `-f` it replaces — no report, no
  "which package owns this", no
  all-or-nothing. Chapter 7's refusal
  ceremony starts to look like a
  feature.
- **Folding is yours too.** A hand
  setup either links every file
  individually (many links to track) or
  links whole folders and rediscovers
  chapter 2's sharing problem by hand
  the day a second tool wants the same
  folder.

A common honest path: start by hand,
and adopt Stow the day the link count
makes you write a script to manage
them — at which point you were writing
Stow, badly, and can stop.

## A sentence for the rest of the street

Other dotfile tools — yadm, rcm, vcsh,
dotbot and more — live between these
two poles, variously adding Git
integration, tagging, or install
scripts to the same basic problem. The
lab did not run them; the choice that
matters is the one above: links or
copies, layout or decisions. Everything
else is taste.
