






  
## Interacting with git

There are a couple of different ways of interacting with git.  The
canonical way is via the command line.  This is different to R's
command line, and is probably not familiar to most people here.
Anyone who took the software carpentry bootcamp in Febuary 2013 though
will find it familiar.  This allows access to all of git's features.
If you use git a lot, you're really going to want to learn this.


# Intermediate git: branching

http://www.sbf5.com/~cduan/technical/git/git-2.shtml

The head:
http://stackoverflow.com/questions/2304087/what-is-git-head-exactly

Nonlinear history:
http://perl.plover.com/classes/git/samples/slide024.html

http://perl.plover.com/classes/git/samples/slide033.html


# Advanced stuff

Not everyone agrees what should be done.  Some people eschew rebase
and history rewriting tools:
http://paul.stadig.name/2010/12/thou-shalt-not-lie-git-rebase-ammend.html

While others (including, not surprisingly, git's author) promote them
http://lwn.net/Articles/328438/

Bear in mind that there are a large number of things that version
control can do for you, and you can't optimise them all equally.

For example, the first article linked
(http://paul.stadig.name/2010/12/thou-shalt-not-lie-git-rebase-ammend.html)
says that you should not use `git merge --squash` because that lies by
taking a bunch of commits and joining them together to create some
mega-commit.  At the same time it wants to preserve the ability to run
`git bisect` on every commit (i.e., code compiles, runs and passes
tests).  In a perfect world this would be fine, because every commit
will work.  But sometimes when doing major reworking, you will break
things.  Sometimes it makes sense to have a feature branch that you
commit to incrementally for your own sanity, tracking your progress
without being too worried about breaking things.  At this point, you
either break `git bisect` (your code won't work for some commits) or
you might squash commits (or use more complicated rewriting).  You
can't satisfy both constraints.  And history rewriting seems like a
much better use of the tools than avoiding making commits in this
case.

These issues have been explained far better elsewhere:
http://darwinweb.net/articles/the-case-for-git-rebase
http://gitguru.com/2009/02/03/rebase-v-merge-in-git/

http://notes.envato.com/developers/rebasing-merge-commits-in-git/

# Resources

Git from the bottom up: internals and gory details
http://ftp.newartisans.com/pub/git.from.bottom.up.pdf
