---
layout: page
title: "Introduction to git"
date: 2013-04-04 09:00
comments: true
sharing: true
footer: false
---

I'm using "ecologists" as a shorthand here.  It's not an exclusive
term -- many geneticists or other scientists will do the same thing,
or have the same needs.

# Hacking version control

* Commented out bits of code / text
* Files with numbers afterwards (`thesis_v1.doc`, `thesis_v2.doc`,
  `thesis_final.doc`, `thesis_final2.doc`, etc)
* Zip up the whole project directory every so often and save it with
  the date appended to the filename.
  
  
Most ecologists seem to invent at least one of these techniques for
doing version control
  
In addition, you'll often see people suggesting putting headers like
this in your code file:

```
  ## My file (c) Rich FitzJohn
  ## Created: 2012/10/04
  ## Modified: 2013/04/04
```

Sometimes you'll even see changelogs embedded in these.

The problem with this is that it's repetitive and boring, it's
difficult to extract the information easily (e.g., get me all the
files **I** modified in the last month), there is no checking on the
contents of the fields (dates in the future, forgetting to update
dates, inconsistent names, email addresses).  The *point* of these
headers is nice --- keep track of who did what and when, but this is
far easier to do with version control.

# Why use version control?

## The fossil record

## Automatic lab notebook

## Freeing yourself to delete things




# Workflows

Before starting with git, let's identify a few workflows that
scientists actually use, then try and map git onto them (rather than
the other way around).  These are workflows that people already do.

## 1. The lone scientist

This workflow will seem very familiar to anyone working on a project
where they are the main contributor, especially PhD students.

## 2. Computer sync 

I have a desktop for doing computing that requires grunt, and a laptop
for cafe work or travel, and I need to keep my projects synchronised.
[Dropbox](http://www.dropbox.com) largely solves this problem when you
don't care about version control, and some people will use it with the
workflow above.

However, this can lead to corruption in your git repository (e.g., if
the network connection is a bit flakey and part of the `.git`
directory is migrated, changes are made on one copy, then conflicted
copies appear corrupting the repository -- and all of its history).

In this workflow, you will usually work on computer A, "push" all your
changes to a server (say, bitbucket or github), then "pull" changes
down to computer B, work on that, and push the changes up onto the
server (rinse and repeat).

This workflow works great, until you do work on both computers in
which case you'll find yourself doing "Synchronous collaboration"
(below) with yourself.

## 3. Asynchronous collaboration

This is essentially the model that you do when you do track changes
with your supervisor.  In this workflow, you do some work, then your
collaborator does some work.  You then review their work and apply it
to yours.

A bit of mental gymnastics reveals that this is actually *exactly the
same* as the workflow above (computer sync).  But now computer B
happens to be owned by somebody else, and you don't always accept all
their changes.

It also becomes clear that you could possibly both edit the files at
the same time, or that you might have more than one "other" person, in
which case you are again doing "Synchronous collaboration".

## 4. Synchronous collaboration

In this case here, you have multiple people working on the files at
the same time.  Different people may make changes to different files
at the same time.  It quickly becomes necessary to denote a
"canonical" copy.

Most software projects in the world operate in this way, but this is
not actually that common for ecologists.  This is the jumping off
point for most dicussions on using version control, but we'll leave it
until later.


# Learning git

Git has a reputation for being hard to learn:

<blockquote class="twitter-tweet"><p>They say git gets easier once you get the basic idea that branches are homeomorphic endofunctors mapping submanifolds of a Hilbert space.</p>&mdash; Kornel (@pornelski) <a href="https://twitter.com/pornelski/status/316190292443267073">March 25, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

One of the things that will make learning git challenging for many
ecologists is that most resources (e.g., the excellent
[git book](http://git-scm.com/book/) assume that you are coming from a
background of using CVS, SVN or some other centralised version control
system.  Therefore, they expect you to already be thinking in one way
and then show you how to translate those ideas into git's ideas.

In a way you're lucky, as you don't have to learn a bunch of stuff and
then unlearn it (see
[here](http://www.reddit.com/r/programming/comments/embdf/git_complicated_of_course_not_commits_map_to/c196s4w)).
Some of the things that git does just make sense with cheaper
bandwidth and disk space than the systems that were developed in the
past.

For example, git keeps a full copy of the history in *every
repository*, while CVS and SVN do not.  But if you didn't know that
different systems did different things, you might easily assume either
is reasonable behaviour (probably the former).  This apparently small
difference then goes on to influence most of the other features of the
systems.

# Git basics

We're going to need some terminology:

* **Working directory**: This is your copy of a project.  It's just a
  directory with files and other directories in it.
* **git directory**: This *is* the repository; it's `git`'s copy of
  your files, in its special format.  This is where the history is
  kept.
* **Staging area**: This is a place for gathering your thoughts as you
  begin to mark new versions.
  
## Interacting with git

There are a couple of different ways of interacting with git.  The
canonical way is via the command line.  This is different to R's
command line, and is probably not familiar to most people here.
Anyone who took the software carpentry bootcamp in Febuary 2013 though
will find it familiar.  This allows access to all of git's features.
If you use git a lot, you're really going to want to learn this.

## Setting up git for command line use

Obviously, you need git installed.  Check to see you have it installed
by running `git --version`, which will produce output like this:

```plain
~ » git --version
git version 1.7.9.6 (Apple Git-31.1)
```

if installed, and an error like this:

```plain
~ » git --version
bash: git: command not found
```

if not installed.  To install git, just download it from the
[git website](http://git-scm.com).

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

## Editor
The default editor is [`vi`](http://vim.com) -- if you have used this
before, this will probably be fine, but if not you are in for a rude
shock.  So, next, let's set that to be a better option.  If you want
to stay on the command line, `nano` is a nice lightweight choice.

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
*e**x**it*), answering "Y" when prompted to save the file.

On a Mac, it is possible to use something like "TextEdit" to edit the
file, by running

```
git config --global core.editor 'open -t -n -W'
```

There is a catch though; you have to make sure that you **quit** the
application after writing your message.  The `-n` option means that
this is *new* instance of TextEdit so you won't lose other open work
when doing this at least.

## More options

Adding the `--tempfile` option will cause `nano` to save on exit
without prompting or asking about the filename.  This can be nice to
avoid being bothered the whole time.

```
git config --global core.editor '/usr/bin/nano --tempfile'
```






# Intermediate git: branching

http://www.sbf5.com/~cduan/technical/git/git-2.shtml

The head:
http://stackoverflow.com/questions/2304087/what-is-git-head-exactly

Nonlinear history:
http://perl.plover.com/classes/git/samples/slide024.html

http://perl.plover.com/classes/git/samples/slide033.html


# Advanced stuff

Not everyone agrees what should be done.  Some people eschew rebase
and history rewriting tools:
http://paul.stadig.name/2010/12/thou-shalt-not-lie-git-rebase-ammend.html

While others (including, not surprisingly, git's author) promote them
http://lwn.net/Articles/328438/

Bear in mind that there are a large number of things that version
control can do for you, and you can't optimise them all equally.

For example, the first article linked
(http://paul.stadig.name/2010/12/thou-shalt-not-lie-git-rebase-ammend.html)
says that you should not use `git merge --squash` because that lies by
taking a bunch of commits and joining them together to create some
mega-commit.  At the same time it wants to preserve the ability to run
`git bisect` on every commit (i.e., code compiles, runs and passes
tests).  In a perfect world this would be fine, because every commit
will work.  But sometimes when doing major reworking, you will break
things.  Sometimes it makes sense to have a feature branch that you
commit to incrementally for your own sanity, tracking your progress
without being too worried about breaking things.  At this point, you
either break `git bisect` (your code won't work for some commits) or
you might squash commits (or use more complicated rewriting).  You
can't satisfy both constraints.  And history rewriting seems like a
much better use of the tools than avoiding making commits in this
case.

These issues have been explained far better elsewhere:
http://darwinweb.net/articles/the-case-for-git-rebase
http://gitguru.com/2009/02/03/rebase-v-merge-in-git/

http://notes.envato.com/developers/rebasing-merge-commits-in-git/

# Resources

Git from the bottom up: internals and gory details
http://ftp.newartisans.com/pub/git.from.bottom.up.pdf
