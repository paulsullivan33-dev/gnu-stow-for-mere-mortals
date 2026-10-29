# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's fixture files are small stock configurations
   written for the guide.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 13 names what the tool
   cannot do: no templating or per-machine decisions, no
   secrecy for stowed files, links and only links, the
   folded-folder trap, one version of a program stowed into a
   prefix at a time, and removal that stops at the links.
8. **The ethics rule is in the text, early.** Stow raises no
   interception question of the kind other guides in this
   series carry, but chapter 1 and the README draw its own
   line plainly — a link does not hide anything, so passwords,
   keys and tokens never belong in a stowed package — and it is
   stated before any procedure depends on it.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a shared Ubuntu 24.04 sandbox; the lab ran
under a scratch tree inside this repository (`stow-lab/work/`)
with a fake home folder, and never touched the machine's real
home. Stow **2.3.1** was used throughout, from the Ubuntu
package `stow_2.3.1-1`.

One circumstance belongs in the open: the sandbox is shared
with other work, and its package manager's lock was held by
that other work for the whole lab session — repeated
`apt-get install stow` attempts across several hours never
found the lock free. The lab therefore downloaded the
distribution's own package file (`apt-get download stow`) and
ran the identical program extracted from it, unmodified — the
Perl script and its two module files placed on the lab's PATH
— rather than the same files placed at `/usr/bin/stow` by an
install. The version output, the option list and every
behaviour in the transcripts are the shipped program's;
`t00` includes the `apt-cache policy` output showing this
exact version as the distribution's candidate. Nothing in the
chapters depends on the difference, and chapter 3 teaches the
ordinary `apt install` a reader will actually use.

The fixture is this guide's own and deliberately generic:
three small packages (an editor configuration, a shell
configuration, two one-line scripts), a hand-written file
invented to conflict with them, and a nine-line C program that
exists only to be installed, upgraded and removed. No real
person's dotfiles, machine, or organisation appears anywhere.
`stow-lab/run-lab.sh` rebuilds the whole lab from scratch and
regenerates every transcript; `stow-lab/make-fixture.sh`
materialises the fixture tree anywhere.

Run for real, with transcripts as evidence:

- The version and help output, the Perl shebang, and the
  distribution's candidate version (t00).
- First stow of the `editor` package: `.vimrc` linked and
  `.config` folded into a single link; `find` counts exactly
  two links; the file reads through the link (t01).
- Folding's full cycle: stowing `shell` unfolds `.config`
  into a real folder of per-package links, unstowing it
  refolds `.config` to a single link (t02).
- The `scripts` package: the target's `bin` is itself one
  folded link; the scripts run through it and from PATH
  (t03).
- Restow: a file added to a package is absent from the target
  until `stow -R`, and editing a package file is live through
  its link with no restow at all (t04).
- Unstow of all three packages leaves a hand-made,
  never-stowed file untouched and every package file intact
  (t05).
- The conflict refusal for a real file in the way — the exact
  three-line warning, exit 1, and proof that the package's
  uncontested `.config` was not linked either (t06).
- `--adopt`: the hand-written file moves into the package,
  replacing the package's own `.vimrc`, and the target ends
  stowed (t07).
- Ignore rules end to end: the built-in list already excludes
  a `.git` folder, a `~` backup and a root `README.md`; a
  `.stow-local-ignore` replaces that list wholesale — `.git`
  demonstrably returns until the pattern is repeated in the
  local file; a `.stow-global-ignore` replaces it the same
  way; `--ignore` applies to one run only (t08). The built-in
  list quoted in chapter 9 was read from the installed
  program's own source.
- `-d`/`-t` with a non-home target: relative links written,
  unstow leaves the target empty (t09).
- The software tree, in a scratch prefix: the lab's C program
  built and installed as `hello-1.0`, stowed into the prefix
  and run; version 2.0 built beside it; the cross-package
  conflict quoted word for word; the unstow/stow swap;
  removal leaving only the empty tree (t10).
- `.stowrc` supplying `--dir`/`--target` to a bare `stow`
  run from an unrelated directory, and `-n -v` simulation
  printing its plan and changing nothing (t11).
- Failure evidence: the missing-package error (exit 2), a
  deliberately dangling link — `ls` shows it, `cat` fails,
  `chkstow` names it — and unstow cleaning it up (t12).
- The `--dotfiles` flag: without it `dot-bashrc` links under
  its literal name; with it the target link is `.bashrc`
  (t13).

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- Stow on other distributions and on macOS, and the current
  2.4 series: the options used here are long-standing, but
  exact message wording can differ between series, and the
  guide says so where it quotes messages.
- A real `/usr/local` whose `bin` and `share` already exist
  as real folders: chapter 10's claim that Stow then links
  file by file follows from the folding behaviour verified in
  an empty prefix (t02, t10), but the lab's prefix was empty
  and folded whole folders; the text states this.
- The neighbours of chapter 12: Chezmoi is characterised from
  its documentation (it has its own guide in this series);
  yadm, rcm, vcsh and dotbot are named in one sentence, not
  evaluated. Symlinks by hand are plain Unix and were used
  throughout the lab's own plumbing.
- Programs that misbehave through symlinks, filesystems
  without symlink support, and Stow on Windows: named as
  limits in chapter 13 from the manual's portability notes,
  not exercised.
- The `--defer` and `--override` options for adjudicating
  between packages by hand: real, documented, and left out
  of the chapters deliberately — conflicts plus adoption
  cover the beginner's ground, and the manual's section is
  the next step.
