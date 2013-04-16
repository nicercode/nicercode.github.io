---
layout: page
title: "Workflows that use version control"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Before starting with git, let's identify a few workflows that
scientists actually use, then try and map git onto them.  Hopefully,
these are workflows that people already use.

<!-- RGF: alter the comments below so that there is no direct mention
	of git, or of repository.  Or use this as an opportunity to
	introduce the comments in an abstract way that is independent of
	the implementation. -->

## 1. The lone scientist

This workflow will seem very familiar to anyone working on a project
where they are the main contributor, especially PhD students.  You do
some work, and then you save the contents of your directory.  It looks
like:

1. Do work
2. checkpoint
3. goto 1

## 2. Computer synchronisation

This is probably familar to anyone who has two computers.

I have a desktop for doing computing that requires grunt, and a laptop
for cafe work or travel, and I need to keep my projects synchronised.
[Dropbox](http://www.dropbox.com) largely solves this problem when you
don't care about version control, and some people will use it with the
workflow above.

However, this can lead to corruption in your git repository (e.g., if
the network connection is a bit flakey and part of the `.git`
directory is migrated, changes are made on one copy, then conflicted
copies appear corrupting the repository -- and all of its history).
This may also not be ideal if one of the computers is a mac and the
other is Windows.  Another issue happens if both end up simultaneously
edited, as you end up with filenames like `xxxx (conflicted copy).R`,
which would break any script that relied on `xxxx.R`

In this workflow, you will usually work on computer A, "push" all your
changes to a server (say, bitbucket or github), then "pull" changes
down to computer B, work on that, and push the changes up onto the
server (rinse and repeat).  Notice that there is a third computer
involved here.

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
at the same time.  It quickly becomes desirable to denote a
"canonical" copy.

Most software projects in the world operate in this way, but this is
not actually that common for ecologists.  This is the jumping off
point for most dicussions on using version control, but we'll leave it
until later.
