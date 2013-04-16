---
layout: page
title: "Setting up git"
date: 2013-04-09 18:44
comments: true
sharing: true
footer: true
---

The default installation of git leaves you with a fairly spartan
interface.  These are some of my tips for making it more pleasant to
use.  On Windows, this is accessed through `git bash`, and on Mac,
accessed through the terminal.

Obviously, you need git installed.  Check to see you have it installed
by running `git --version`, which will produce output like this:

```plain
git version 1.7.9.6 (Apple Git-31.1)
```

If not, [install git](installation.html) first!

The first thing is to set your name and email.  These will appear all
over the place, so they are good to set up first.  It feels a bit
weird if you're the only person using a reposirory, but you only have
to set this once.  So run

```
git config --global user.name "Your Name"
git config --global user.email your.email@domain.com
```

These are *global* options and will affect all repositories.  These
can actually be over-ridden on a per-repository basis, but you don't
generally need to do that.  The configuration options go into the file
`~/.gitconfig` (the `~` means "home" in unix commands).

### Editor

The default editor is [`vi`](http://vim.com) -- if you have used this
before, this will probably be fine, but if not you are in for a rude
shock.  So, next, let's set that to be a better option.  

#### On a Mac

First, check that you have `nano` installed by typing 

```
which nano
```

and then running

```
git config --global core.editor '/usr/bin/nano'
```

(but change the path to reflect where it is installed.  In most
situations it will be `/usr/bin/nano`).

Whenever git needs you to write a message on a commit, it will pop
open `nano`.  Write the message and quit with `Control-X` (*X* for
*exit*), answering "Y" when prompted to save the file.

Adding the `--tempfile` option will cause `nano` to save on exit
without prompting or asking about the filename.  This can be nice to
avoid being bothered the whole time.

```
git config --global core.editor '/usr/bin/nano --tempfile'
```

However, it removes the ability to easily abort a commit by not saving
the message.

On a Mac, it is possible to use something like "TextEdit" to edit the
file, by running

```
git config --global core.editor 'open -t -n -W'
```

There is a catch though; you have to make sure that you **quit** the
application after writing your message.  The `-n` option means that
this is *new* instance of TextEdit so you won't lose other open work
when doing this at least.

#### On Windows

The simplest solution is to set

```
git config --global core.editor notepad
```

which will use notepad.  Notepad makes a bit of a mess of the files
when you edit them, but will be good enough to get you going.  Longer
term, you may find something like using
[notepad++](http://www.notepad-plus-plus.org) more enjoyable, but
[setting this up is a bit of a hassle](http://stackoverflow.com/questions/1634161/how-do-i-use-notepad-or-other-with-msysgit/2486342#2486342).

### Colour

By default (on **Mac** and **Linux** at leat), the command line is
fairly stark, but git has options to spruce it up with nice colours.
More than just look pretty, these allow you to much more easily scan
output.

Just run

```
git config --global color.ui true
```

and the output of `status` and `diff` (and a few others) will be
coloured for you.
