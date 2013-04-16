---
layout: page
title: "Git basics"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Essentially, all version control does is store snapshots of your work
in time, and keeps track of the parent-child relationship.

{% imgcap right /git/img/git-intro-history.png From [Pro Git](http://git-scm.com/book/en/Getting-Started-Git-Basics) %}

You can think of your current set of working files are simply the
child of the last node in this chain (that is, your files are the
children of the most recent set of files known to the version control
system).

`git` provides a large number of tools for manipulating this history.
We'll only touch on a few, but the number that you need to know for
day-to-day use is actually quite small.

	
<!-- RGF: Not sure what this adds, or if it is precice enough -->

We're going to need some terminology:

* **Repository**: "Repo" for short; this is a copy of the history of
  your project.  It is stored in a hidden directory within your
  project.  People will talk about "cloning a repo" or "adding things
  to a repo"; these all manipulate the history in some way.
* **Working directory**: This is your copy of a project.  It's just a
  directory with files and other directories in it.  The repository is
  contained within a `.git` directory.
* **git directory**: This *is* the repository; it's `git`'s copy of
  your files, in its special format.  This is where the history is
  kept.
* **Staging area**: This is a place for gathering your thoughts as you
  begin to mark new versions.
  
## How history grows

Think of your work as a series of snapshots backwards in time from now
until the point a project was created.  The simplest history is that
you did some work and saved, did some work and saved, etc.  If we let
`v1`, `v2` and `v3` be three versions (of increasing newness) we can
draw a history like this:

```
  -- time ----->
  v1 <- v2 <- v3
```

Read this as "the parent of `v3` is `v2` and the parent of `v2` is
`v1`".  These "versions" are entire snapshots of all the files in your
project directory.  Version `v3` is the "current" version, so git
gives that a special label called `HEAD`:

```
  -- time ----->
  v1 <- v2 <- v3
              ^
			 HEAD
```

This is what is checked out in a directory.  There are ways of moving
`HEAD` around, which will allow us to compare against older version,
but we're getting ahead of ourselves.

Say you make a bunch of changes to your files in the working
directory.  The idea is simply to tell git that these files have
changed, and have it extend the tree:

```
  -- time ----------->
  v1 <- v2 <- v3 <- v4
```

We will refer to this operation as **commiting** and each of the
separate `v` snapshots as **commits**.

## More theory

Branches are easy.  Remember our simple history:

```
  -- time ----->
  v1 <- v2 <- v3
```

We can make a new branch off any commit.  So if we rolled back to `v2`
and did some work, our history would look like this:

```
  -- time ----->
  v1 <- v2 <- v3
         ^
		  \
		   v4
```

now we have two branches.  It will be useful to label these:

```
  -- time ----->
  v1 <- v2 <- v3
         ^     ^
		  \    master
		   v4
		   ^
		   feature
```

The branch `master` is the default name that git gives to a branch
(you'll see it anywhere).  There is nothing special about this name
apart from convention.  But convention is special as it helps people
understand what you've done.  Many people (RGF: who?) will say that
you should not work on master, but in practice most biologists tend to
(look up any project on github).

We also need to know which branch is checked out.  This is determined
by the `HEAD` pointer:

```
  -- time ----->
  v1 <- v2 <- v3
         ^     ^
		  \    master
		   v4
		   ^
		   feature
		   ^
		   HEAD
```

Here, `HEAD` points at `v4`, so that is checked out.
