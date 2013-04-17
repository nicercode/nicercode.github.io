---
layout: page
title: "Git basics (command line)"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

*This will become basics.md once basics.md becomes rstudio.md*

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
  
# Creating a repository

If you want to create a repository from the command line, use the
command

```
git init
```

which will print something like

```
Initialized empty Git repository in /Users/rich/Desktop/vc/.git/
```

I have deleted the `.git` directory in the `vc` project, and
re-initialised an empty git repository there.

# The add-commit cycle, revisited

We will use a few commands.

The first is `git status`.  This tells you the status of all the files
in your project that *are not up to date*.  At the moment, it
contains:

```
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
#	script.R
#	vc.Rproj
nothing added to commit but untracked files present (use "git add" to track)
```

which is essentially the same information as

{% img img/rstudio-not-added.png %}

The command `git add` does (essentially) the same thing as clicking
the "Staged" checkbox in Rstudio:

```
git add script.R
git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   script.R
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
#	vc.Rproj
```

This tells us all of the things that we are going to commit
(`script.R`) and the files that git does not know about (`.gitignore`
and `vc.Rproj`).  The command `git commit` does the actual addition.
The `-m` option passes in a message for the commit.

```
git commit -m "Added function that computes standard error of the mean."
```

which prints

```
[master (root-commit) 514f871] Added function that computes standard error of the mean.
 1 file changed, 3 insertions(+)
 create mode 100644 script.R
```

which is essentially the same information that RStudio showed after
committing.

We can add the other files:

```
git add .gitignore vc.Rproj
git commit -m "Added RStudio
```
