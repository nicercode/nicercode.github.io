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
