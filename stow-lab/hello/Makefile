# A deliberately ordinary Makefile for the lab's tiny program.
# "make install PREFIX=/some/folder" installs into that folder,
# laying out bin/, share/hello/ and share/man/man1/ inside it --
# exactly the shape a Stow package needs.

VERSION ?= 1.0
PREFIX  ?= /usr/local
CC      ?= cc
CFLAGS  ?= -O2 -Wall

hello: hello.c
	$(CC) $(CFLAGS) -DVERSION_STR='"$(VERSION)"' -o hello hello.c

install: hello
	install -d $(PREFIX)/bin
	install -d $(PREFIX)/share/hello
	install -d $(PREFIX)/share/man/man1
	install -m 0755 hello $(PREFIX)/bin/hello
	echo "This message belongs to hello $(VERSION)." \
	    > $(PREFIX)/share/hello/message.txt
	install -m 0644 hello.1 $(PREFIX)/share/man/man1/hello.1

clean:
	rm -f hello

.PHONY: install clean
