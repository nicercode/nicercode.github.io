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
git commit -m "Added RStudio files"
```

which will print 

```
[master 519a8e3] Added RStudio files
 2 files changed, 16 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 vc.Rproj
```

To see the history

```
git log
```

which will print something like

```
commit 519a8e3b3c0558faf8b0ad9c6d7d269e72a6571a
Author: Rich FitzJohn <rich.fitzjohn@gmail.com>
Date:   2013-04-17 14:08:09 +1000
 
    Added RStudio files
 
commit 514f871aa41127f94daaeb3360dda6a70ec3fb36
Author: Rich FitzJohn <rich.fitzjohn@gmail.com>
Date:   2013-04-17 11:51:54 +1000
 
    Added function that computes standard error of the mean.
```

## What is going on with those crazy strings of numbers?

You may have noticed the long strings of numbers, such as:

```
commit 519a8e3b3c0558faf8b0ad9c6d7d269e72a6571a
```

These are called "hashes"; think of them as a fingerprint of a file,
or of a commit.  Git uses them everywhere, so these get used where you
would otherwise use "version1", or "final", etc.

The nice thing about them is that they depend on the entire history of
a project, so you know that your history is secure.  For example, I
deleted the full stop at the end of the first commit message
([don't ask me how](http://stackoverflow.com/a/2119656)) and reran
`git log`

```
commit a0f9f692319eb7103bd0485181b45c3bf229851f
Author: Rich FitzJohn <rich.fitzjohn@gmail.com>
Date:   2013-04-17 14:08:09 +1000

    Added RStudio files

commit 9b5f828a285577d53dc40a28fa3cd7e4cc1a691d
Author: Rich FitzJohn <rich.fitzjohn@gmail.com>
Date:   2013-04-17 11:51:54 +1000

    Added function that computes standard error of the mean
```

You might expect that the hash for the first commit would change, but
notice that it is has changed a *lot* for just one character
difference.  Also notice that the second commit has a new hash too;
this is because one of the "things" in the second commit is a pointer
back to the first commit indicating who its parent is.

Confused?  Don't worry.  All you need to know is that the hash
identifies your **entire project including its history**, and that if
anything changes anything in the project, the hashes will change.
This is great because it allows us to use the big ugly strings of
letters and numbers as a shortcut for a very precise set of
information.

## What changed?

The other thing that we could do in RStudio is see the lines of code
that changed.  This is incredibly useful, and once you start thinking
with version control you'll constantly look to see what has changed.
The confidence that you can always go back is what makes version
control empowering.

Suppose we change the `script.R` file again:

```r
# Standard error function
se <- function(x, na.rm=TRUE) {
  n <- if ( na.rm ) length(na.omit(x)) else x
  sqrt(var(x, na.rm=na.rm) / n)
}
```

we'll see that `git status` reports that the file has changed:

```
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   script.R
#
no changes added to commit (use "git add" and/or "git commit -a")
```

The command `git diff` shows the change between the contents of the
working directory and the changes that would be commited.  So with
nothing to commit, this is the difference between the files in the
directory and the last revision.  Running `git diff` reports:

```plain
diff --git a/script.R b/script.R
index 22431f2..9f9ad79 100644
--- a/script.R
+++ b/script.R
@@ -1,3 +1,5 @@
 # Standard error function
-se <- function(x)
-  sqrt(var(x, na.rm=TRUE) / length(na.omit(x)))
+se <- function(x, na.rm=TRUE) {
+  n <- if ( na.rm ) length(na.omit(x)) else x
+  sqrt(var(x, na.rm=na.rm) / n)
+}
```

if we add the file to "stage" it with:

```
git add script.R
```

and rerun `git diff`, there is no output.  The command `git status`
now reports

```
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   script.R
#
```

indicating that `script.R` will be added when we do `git commit`.  You
can review what would be commited line-by-line by running

```
git diff --cached
```

which compares the contents of the staged changes with the previous
version.

*(Probably worth reviewing the three stage git figure here, and
 perhaps indicating that it is possible to do a working-directory vs
 last-commit diff with* `git diff HEAD`*)*
 
