### Version control and word

When talking about branches, talk about how track changes nightmares
work in Word.  Do the one-person track change scenario
(async. collab), then talk about how multiple people getting involved
makes it harder.  Talk about how one of the things that makes this
hard is again the metadata issue -- we never really capture who
branched off whom.

### Reverting things

This is one of the big selling points.  Make it clear that what I do,
and what many people do, is just go rummaging around on one of the
websites.  I can show an example from github perhaps.  Make point that
it is easier to remember how to poke around a website than to remember
syntax if you don't use it regularly.

Go back to an old version:
   `git checkout -b new_master`
   `git revert`
  
Or more adventurously (for unpublished history)
   `git checkout -b master_backup`
   `git branch -d master`
   `git checkout -b master old_version`
  
Go back to old version of single *file*
   `git checkout old_version -- path/file.R`
followed by 
   `git add path/file.R`
   `git commit path/file.R -m "Restored old version of file"`
to add it to the repository.

Discard working copy changes for a single file
   `git checkout -- path/file.R`
Multiple files is harder -- can be done with `git reset HEAD`, but I
like
   `git stash`
   `git stash drop`

Unstage changes (as mentioned in `git status`)
   `git reset HEAD path/file.R`
possibly followed by 
   `git checkout -- path/file.R`
to discard local changes too

Related: view file from previous version
    `git show old_version:file/path.R`

### Localisation

If you want dates in ISO 8601 (YYYY-MM-DD) format (rather than in
Month Day, Year format), run this command

```
git config --global log.date iso
```

### Useful aliases

Git allows you to define aliases for frequently used commands.  So
instead if typing

```
git merge --ff-only somebranch
```

you can just type (for example)

```
git ff somebranch
```

To set up aliases either use `git config` again:

```
git config --global alias.ff 'merge --ff-only'
```

Or edit your `~/.gitconfig` file so it contains a section `[alias]`
like this:

```
[alias]
        ff   = merge --ff-only
```

My full set of aliases is

```
[alias]
        lol = log --graph --decorate --pretty=oneline --abbrev-commit
        lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
        topo = log --graph --simplify-by-decoration --pretty=format:'%d' --all
        ff   = merge --ff-only
        mrg  = merge --no-ff
```

The first (`lol` = "log one line") gives a very quick view of the
history of a repository, including its topology.  `lola` does a
similar thing, but includes remote branches too (and stashes, but
they're usually hard to interpret).  `topo` shows just the topology.

The `ff` alias will merge a commit, but only if a "fast forward"
commit is possible.  Otherwise it will throw an error and I'll think
about doing a rebase or a merge instead.

The `mrg` alias will do a merge *even if a fast forward commit is
possible*.  This is sometimes useful for merging in feature branches
when the main branch has not changed.

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
