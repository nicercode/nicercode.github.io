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
  
## Baby steps with RStudio

RStudio has git built in, and we're going to use that to get started.
The set of things you can do with git through RStudio is quite
limited, but if you're doing your work there already, it will be quite
convenient.

First, make a branch new project (see
[this post](blog/2013-04-05-projects/#setting-up-a-project-in-rstudio),
but essentially Project: Create Project).

Click the "Rproj" file in the "Files" pane, or click Projects:
Projects Options to open the project options.  Select the bottom entry
in the ribbon (Git/SVN), and select Git from the drop-down menu.
RStudio will prompt you to confirm, and then again to restart -- click
"Yes" both times.

Now the top right panel has a "Git" tab, which should look like this

{% img img/rstudio-on-init.png %}

The two question marks next to the files indicate that they are not
known to git.

### Adding and committing files to git

Make a new R script (say, `script.R`, imaginatively), and edit it,
perhaps to say:

```r
# Standard error function
se <- function(x)
  sqrt(var(x) / length(x))
```

{% img img/rstudio-not-added.png %}

Our new file is now listed, also with question marks as it also not
known to git.

If you click the check box next to `script.R`, the two question marks
change to one "A".  This indicates that the file has been "added"
(specifically, we've added it to the staging area, indicating that we
are planning on making that file part of the next revision of the
project).

{% img img/rstudio-added.png %}

This file is still not under version control though; we've just
indicated our *intention* to add it.  Click the "Commit" button (with
the little tick mark) and the "Review Changes" window opens.

{% img img/rstudio-review-changes.png %}

Enter a descriptive message about your change here.  Convention
suggests a one line informative message, which is if necessary
followed by a blank line and a more detailed message if the change
warrants it.  I added the message:

```plain
Added function that computes standard error of the mean.
```

The pane on the left indicates the state of your directory (in this
project two "unknown" files and one staged to be commited.  The bottom
pane contains the changes -- in this case the entire file is new so
everything is green.

When you are happy, press "Commit", and a small log window opens up
telling you everything went well.  Mine said:

```
[master (root-commit) 765f3d6] Added function that computes standard error of the mean
 1 file changed, 3 insertions(+)
 create mode 100644 script.R
```

Notice that the file we added has been removed from the Git pane.
This is because there are no operations that we might want to do to
update the history of that file (i.e., it is up to date).

{% img img/rstudio-on-init.png %}

There are two other files here; a `.gitignore` file and a file called
`vc.Rproj` (or `your_project_name.Rproj`).  The first is useful for
keeping track of which files we *don't* want to keep track of (e.g.,
generated figures, data, etc), and the `Rproj` file is how RStudio
keeps track of things.  I added these (tick checkboxes, then Commit,
with message `Added RStudio files to version control.`).

### Viewing history

In the git pane, click "More" (with the small cog) and click
"History".  This opens up a window also labeled "Review Changes" that
shows the history for the project.

{% img img/rstudio-history.png %}

The two revisions are indicated by the two rows in the top panel, with
the most recent version at the top, and time running backwards down
the list.  You can see the short line added as a commit messages,
along with the author who made the change and the date the change was
made.  The numbers in the far right column are a "SHA hash" -- we'll
talk about these later, but think of it as a fingerprint for that
version.

The bottom panel includes information about the selected version
(versions are also often called commits, so RStudio says "Commits 1-2
of 2").  This includes the same information more verbosely, then lists
the two files that changed (`.gitignore` and `vc.Rproj`) and then the
difference between these and the previous version of the files.
Because this is the first version of the files, everything is new, so
all lines are green.

### Making changes

Edit the `script.R` file to say

```r
# Standard error function
se <- function(x)
  sqrt(var(x, na.rm=TRUE) / length(na.omit(x)))
```

The git pane now shows that `script.R` has been modified:

{% img img/rstudio-modified.png %}

If you click the check box to stage the file, the "M" moves to the
left to indicate that this change has been staged.  Then commit the
file with an appropriate message, in my case:

```plain
Modified the se function to ignore NA values.
```

If you view the history again, this time you can see red lines
indicating deletions and green lines indicating additions.

{% img img/rstudio-history.png %}


