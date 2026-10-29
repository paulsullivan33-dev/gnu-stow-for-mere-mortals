# Installing Software with Stow

**Outcome: a program you built yourself
is installed, upgraded from 1.0 to 2.0,
and removed completely — with nothing
left behind in the shared folders — the
job Stow was originally written for.**

Chapter 1 promised the second farm. The
arrangement: a **stow tree**, by
tradition `/usr/local/stow`, holds one
folder per program per version. Each
program is installed *into its own
folder* — with the folder laid out as
`bin/`, `lib/`, `share/` — and Stow
links that layout into the prefix
itself, `/usr/local`, whose `bin` is
already on everyone's path. The lab
cannot write to a real `/usr/local` and
would not rehearse on one if it could,
so it built the same shape in a scratch
prefix, `opt/` with its tree at
`opt/stow/`. Every step is the real one;
only the address differs, and on a real
system the same commands run with the
rights to write under `/usr/local`.

## The program

The lab's guinea pig is a nine-line C
program, `hello`, whose whole talent is
printing its version (source and
Makefile: `stow-lab/hello/`). Its
Makefile's `install` target takes a
`PREFIX`, which is the hook every
well-behaved build system offers —
`configure --prefix=...`, `cmake
-DCMAKE_INSTALL_PREFIX=...` and their
kin in bigger projects all do the same
job: *put the program's files under this
folder, in the usual subfolders.*

## Install: build into the tree, stow into the prefix

```text
$ make VERSION=1.0
$ make install VERSION=1.0 PREFIX=../opt/stow/hello-1.0

$ find ../opt -type f | sort
../opt/stow/hello-1.0/bin/hello
../opt/stow/hello-1.0/share/hello/message.txt
../opt/stow/hello-1.0/share/man/man1/hello.1
```

At this point nothing is "installed" in
any sense a user can run — the program
sits in its private folder. Now stand in
the stow tree. Note the defaults doing
their chapter 2 trick: the stow
directory is where you stand, the target
is its parent — the prefix:

```text
$ cd ../opt/stow
$ stow hello-1.0
(exit 0)

$ ../bin/hello
hello, version 1.0
```

(Transcript
`stow-lab/transcripts/t10-software-tree.txt`.)
In the lab's empty prefix, `bin` and
`share` arrived as folded whole-folder
links into `hello-1.0`. On a real
`/usr/local`, `bin` and `share` already
exist as real folders holding other
software, so Stow unfolds and links the
program's files one by one into them —
same program, same reachability, finer
grain of link. Either way, *every* file
the program owns in the prefix is a link
back into its one folder. That is the
property the rest of the chapter spends.

## Upgrade: the two-step

Version 2.0 is built the same way, into
its own folder beside 1.0:

```text
$ make install VERSION=2.0 PREFIX=../opt/stow/hello-2.0
```

Both versions now exist, complete, side
by side. The tempting shortcut — stow
2.0 straight over 1.0 — is refused,
because every path 2.0 wants is a link
owned by 1.0 (chapter 7's other
message):

```text
$ stow hello-2.0
WARNING! stowing hello-2.0 would cause conflicts:
  * existing target is stowed to a different package: bin/hello => ../stow/hello-1.0/bin/hello
  * existing target is stowed to a different package: share/hello/message.txt => ../../stow/hello-1.0/share/hello/message.txt
  * existing target is stowed to a different package: share/man/man1/hello.1 => ../../../stow/hello-1.0/share/man/man1/hello.1
All operations aborted.
```

So the upgrade is a deliberate two-step,
and its deliberateness is the safety:
at no moment is the prefix half-swapped.

```text
$ stow -D hello-1.0
$ stow hello-2.0

$ ../bin/hello
hello, version 2.0
```

And the step back is the same pair in
reverse — 1.0's folder was never
touched, so rolling back an upgrade
that misbehaves is an unstow and a
stow, not a rebuild.

## Removal: nothing left behind

```text
$ stow -D hello-2.0
$ rm -r hello-1.0 hello-2.0

$ find .. -mindepth 1 | sort
../stow
```

The prefix's `bin` and `share` links
vanished with the unstow; the version
folders deleted by hand; the tree
stands empty. No orphaned `hello` files
in shared folders, no manual page left
behind — the classic failure of
hand-installed software, designed away.
On a real system this is the difference
between a `/usr/local` you can account
for and one nobody dares clean.

Two honest limits of the pattern, both
developed in chapter 13: the program
must *agree* to live this way — it has
to run correctly through links and from
its installed layout, which
prefix-respecting programs do and some
hard-coded-path programs do not — and
two versions can exist in the tree, but
only one can be stowed into the prefix
at a time. Side-by-side *active*
versions need another tool's help.
