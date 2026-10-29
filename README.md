# GNU Stow for Mere Mortals

Every computer you use for long grows
the same scatter: an editor's settings
here, a shell's startup file there, a
few scripts somewhere else, each living
where its program demands and nowhere
else. **GNU Stow** gathers that scatter
into one folder of **packages** — files
laid out exactly as they should appear
in your home — and fills the home with
**symlinks** pointing back into the
packages. The real files live in one
place, where they can be backed up,
versioned, and carried to the next
machine; the programs find them where
they always looked. One command installs
a package, one command removes it
without a trace, and the same trick
manages software you build yourself,
version by version, in a shared prefix
like `/usr/local`.

Stow is old — written in 1993, a single
Perl program, essentially finished —
and it does exactly one thing. This
guide teaches that one thing carefully:
the model of stow directories, packages
and targets; the folding behaviour that
decides whether a folder is one link or
many; the conflict report, which is
Stow refusing to overwrite anything,
ever; and the sharp-edged `--adopt`
that settles the argument between a
package and a file you already have by
moving *your* file into the package.

The lab behind this guide ran the real
thing: **Stow 2.3.1**, the Ubuntu
package, on a small Linux machine, in a
scratch home folder built for the
purpose — no real configuration was
ever at risk. Against a three-package
fixture (an editor's files, a shell's
files, two small scripts) it stowed,
watched a shared folder unfold and
refold, restowed to pick up a new file,
unstowed everything and checked what
survived, provoked a conflict with a
hand-written file and read the refusal,
adopted that file into its package,
mapped the ignore rules — including
the trap where a local ignore file
silently dismisses the built-in one —
stowed into targets that were not a
home at all, and built a tiny C program
twice to run the full
install–upgrade–remove cycle in a
scratch `/usr/local`. Every transcript
is kept in `stow-lab/transcripts/`.

What the lab could not do, it did not
fake. Stow on other systems than this
Linux, and the neighbours in chapter 12
beyond their documented behaviour, are
described from their documentation and
labelled as such. `criteria.md` keeps
the full ledger of what was run and
what was only read — including how the
lab came to run the distribution's
package files directly when the
machine's package manager was busy with
other work.

## What this guide covers

- [**What Stow is**](what-stow-is.md) —
  the mental model: one folder of
  packages, links where programs look,
  and why a link never hides a secret
- [**The moving parts**](the-moving-parts.md) —
  the stow directory, the package, the
  target, the links, and folding, the
  behaviour behind most surprises
- [**Installing Stow**](installing-stow.md) —
  one package from your distribution,
  and the version check that proves it
  runs
- [**Your first stow**](your-first-stow.md) —
  the fixture, the one command, and the
  three looks that prove the links are
  what they claim
- [**Packages and targets**](packages-and-targets.md) —
  naming both folders out loud, stowing
  into places that are not home, and
  organising the packages themselves
- [**Stow, unstow, restow**](stow-unstow-restow.md) —
  the three verbs, unfolding and
  refolding as packages come and go,
  and why edits need no ceremony but
  new files do
- [**Conflicts — when Stow says no**](conflicts.md) —
  the refusal, read line by line, and
  the total-abort rule that makes it
  safe
- [**Adopting files you already have**](adopting-existing-files.md) —
  `--adopt`: your existing file moves
  into the package and wins — including
  over the package's own copy
- [**Ignore rules**](ignore-rules.md) —
  the built-in ignore list, your own
  `.stow-local-ignore`, and the
  replacement trap that brings `.git`
  back from the dead
- [**Installing software with Stow**](installing-software-with-stow.md) —
  the stow tree: build into a version
  folder, link into the prefix, upgrade
  as a two-step, remove without a trace
- [**Recipes**](recipes.md) — a dotfiles
  folder from zero, rehearsing with
  `-n -v`, `.stowrc`, the `--dotfiles`
  flag, the first-day adoption walk,
  and auditing with `chkstow`
- [**The neighbours**](the-neighbours.md) —
  Chezmoi, which decides things Stow
  cannot, and symlinks by hand, which
  Stow exists to outgrow
- [**Limits**](limits.md) — no
  decisions, no secrets, no copies; the
  folded-folder trap; one version
  stowed at a time
- [**Troubleshooting**](troubleshooting.md) —
  the missing package error, the quiet
  success that stowed somewhere else,
  dangling links and `chkstow`, and
  folders changing shape
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Templating, per-machine differences,
encryption, and secret management —
Stow does none of them (chapter 12
points at the tool that does, and this
series covers it). Configuration
*management* at fleet scale — many
machines, enforced state — is another
series resident's job (Ansible), not
this one's. And the guide teaches Stow
on Linux; the program runs elsewhere,
but its world is symlinks, and
filesystems and systems that ration
them are noted in chapter 13 rather
than taught.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
four nouns and one behaviour explain
nearly everything that follows, refunds
included. Chapters 3 to 6 take you from
no Stow to a stowed, unstowed and
restowed fixture; rehearse them in a
scratch folder exactly as the lab did
(`stow-lab/run-lab.sh` rebuilds the
lab's whole world, and
`stow-lab/make-fixture.sh` makes the
fixture tree anywhere). Chapters 7 to 9
are the safety equipment — conflicts,
adoption, ignores — and chapter 10 is
the second farm, software you build.
The lab's transcripts live in
`stow-lab/transcripts/`, its fixture in
`stow-lab/fixture/`, and its tiny test
program in `stow-lab/hello/`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Chezmoi for Mere Mortals](https://paulsullivan33-dev.github.io/chezmoi-for-mere-mortals/)
- [Git for Mere Mortals](https://paulsullivan33-dev.github.io/git-for-mere-mortals/)
- [Bash for Mere Mortals](https://paulsullivan33-dev.github.io/bash-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/gnu-stow-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/gnu-stow-for-mere-mortals/blob/main/LICENSE-CODE).
