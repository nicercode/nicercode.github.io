---
layout: page
title: "Git overview"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Essentially, all version control does is store snapshots of your work
in time, and keeps track of the parent-child relationship.

{% imgcap /git/img/git-intro-history.png From [Pro Git](http://git-scm.com/book/en/Getting-Started-Git-Basics) %}

You can think of your current set of working files are simply the
child of the last node in this chain (that is, your files are the
children of the most recent set of files known to the version control
system).

`git` provides a large number of tools for manipulating this history.
We'll only touch on a few, but the number that you need to know for
day-to-day use is actually quite small.


We're going to need some terminology:

* **Repository**: "Repo" for short; this is a copy of the history of
  your project.  It is stored in a hidden directory within your
  project.  People will talk about "cloning a repo" or "adding things
  to a repo"; these all manipulate the history in some way.
* **Working directory**: This is your copy of a project.  It's just a
  directory with files and other directories in it.  The repository is
  contained within a `.git` directory at the root directory of your
  project.
  
## A new repository

Corresponds to project

Should store everyhting in project except outputs: data, scripts, images, notes

Evolves over time, only has current contnet.

Just works.


## The commit cycle

Workflow

- about an hour, regular commits, small chunks
- pictures to show files avdancing
- get them to try online demo
- tag important events
- revert / rollback / checkout old
- 
