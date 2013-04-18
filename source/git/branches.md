---
layout: page
title: "Branches"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

**Note for all that follows:** *This may help you, but if it just
confuses you, forget it.  Just know that this exists, and that it
might be useful.  By the time you're comfortable enough with the core
concepts and tools, this may help.  But you don't **have** to know how
to do branching to use version control.  In fact, branching is fairly
rare in most other version control systems.*

A linear history is fine, but that is often not how science
progresses.

Suppose that you've got your project working, but want to get tidy it
up a bit in a way that requires major surgery and you want to be able
to get back to where you were.

Alternatively, suppose that you want to try two different ways of
implementing something.

In my case, I have a package that I mantain -- sometimes I need to add
bug fixes to the released version without wanting to publish the
broken development code.

What if you wanted to go back to an old version and continue
development from there?

In all of these scenarios, we might want to work on a "branch" of the
project.

## What do branches look like?

*Diagram from pro git book, showing no branches, then branches*

*In class, perhaps draw on the board*

*Diagram of different workflows -- the simple git one, the one Matt
 sent me, the git flow workflow*

*Identify that the branch they are currently on is called master, but
 that is just a convention*
 
## Listing branches

The command `git branch` lists the branches git knows about.  By
default, there is only one branch and it is called `master`.

```
git branch
* master
```

The asterix next to this indicates that this is the *current* branch.
If you pass in the `-v` argument (for **verbose**), you get

```
git branch -v
* master a0f9f69 Added RStudio files
```

which adds the shortened version of the SHA hash and the last commit
message.

## Creating branches

There are two ways of creating branches in git.  The first is to use
`git branch`.  The command 

```
git branch new_idea
```

creates a new branch called `new_idea`, but does not change to it.
Rerunning `git branch -v`:

```
* master   a0f9f69 Added RStudio files
  new_idea a0f9f69 Added RStudio files
```

We now have two branches, both at the same point on the tree.  The
asterix indicates that we are on the branch `master`.

You can change to a branch by using `git checkout`.  So to switch to
the `new_idea` branch, you would do:

```
git checkout new_idea
```

which lets you know that it worked

```
Switched to branch 'new_idea'
```

You can switch back to master by doing

```
git checkout master
Switched to branch 'master'
```

and can delete branches by passing `-d` to `git branch`

```
git branch -d new_idea
```

which prints

```
Deleted branch new_idea (was a0f9f69).
```

The other way of creating a branch and switching to it is 








* Creating branches with `branch` and `checkout -b`
* Switching branches with `checkout`
* How the graph looks
* Combining branches with `merge`
* Combining branches with `rebase`
* The idea of fast-forwarding
* The idea of a nice history
* Creating a branch off an old version

[Git branching demo](http://pcottle.github.io/learnGitBranching/?NODEMO)



