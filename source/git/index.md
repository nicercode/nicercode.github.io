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

Git has a reputation for being hard

https://twitter.com/pornelski/status/316190292443267073

One of the things that will make learning git for most ecologists is
that most resources (e.g., the excellent
[git book](http://git-scm.com/book/) assume that you are coming from a
background of using CVS, SVN or some other centralised version control
system.  Therefore, they expect you to already be thinking in one way
and then show you how to translate those ideas into git's ideas.

In a way you're lucky, as you don't have to learn a bunch of stuff and
then unlearn it.  Some of the things that git does just make sense
with cheaper bandwidth and disk space than the systems that were
developed in the past.

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
