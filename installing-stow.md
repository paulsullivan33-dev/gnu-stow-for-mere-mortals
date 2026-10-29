# Installing Stow

**Outcome: a `stow` command on your
machine that can state its version.**
Stow is a small, old, finished piece of
software — a single Perl program — so
installing it is the shortest chapter in
this guide.

## From your distribution's packages

Stow has been packaged by every
mainstream Linux distribution for
decades. On Debian or Ubuntu:

```bash
sudo apt install stow
```

The lab's machine is Ubuntu 24.04, whose
package is Stow **2.3.1**:

```text
$ apt-cache policy stow
stow:
  Installed: (none)
  Candidate: 2.3.1-1
```

Other distributions carry it under the
same name — `stow` in Fedora's, Arch's
and openSUSE's repositories, and in
Homebrew on a Mac. The lab verified
only the Ubuntu package; the options
this guide uses are all long-standing,
but the manual is the authority for
your version, and message wording
varies a little between the 2.3 series
run here and the current 2.4 series
(chapter 13).

There is usually nothing else to fetch.
Stow is one Perl script with one module
file, and Perl itself is already
installed on effectively every Linux
system — the language is old enough to
be part of the furniture:

```text
$ head -1 "$(command -v stow)"
#!/usr/bin/perl
```

If you ever need to remove it, your
package manager takes it back out the
same way (`sudo apt remove stow`).
Removing the program never touches your
packages or your links' targets — the
links it made stay where they are,
pointing at files that are still there,
and can be removed by hand or by
reinstalling Stow and unstowing
(chapter 6).

## The check

```bash
stow --version
```

```text
stow (GNU Stow) version 2.3.1
```

That line is the whole acceptance test
(the lab's transcript
`stow-lab/transcripts/t00-install-and-version.txt`
keeps it, along with the option list).
`stow --help` prints the full synopsis;
the lines this guide leans on are:

```text
-d DIR, --dir=DIR     Set stow dir to DIR (default is current dir)
-t DIR, --target=DIR  Set target to DIR (default is parent of stow dir)

-S, --stow            Stow the package names that follow this option
-D, --delete          Unstow the package names that follow this option
-R, --restow          Restow (like stow -D followed by stow -S)
```

Plain `stow PACKAGE` means the same as
`stow -S PACKAGE` — stowing is the
default verb. Read the two defaults in
the `-d` and `-t` lines once more,
because chapter 2 warned about them and
chapter 5 builds a habit around them:
the stow directory is *where you are
standing*, and the target is *its parent
folder*. For a `dotfiles` folder inside
your home, those defaults are exactly
right, which is why the dotfiles layout
in the next chapter needs no options at
all.
