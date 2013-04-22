---
layout: page
title: "Remotes"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Git is an example of "distributed version control", in contrast with
earlier models of "centralised version control".  Other distributed
version control systems include
[mercurial](http://mercurial.selenic.com/), [darcs](http://darcs.net/)
and [bazzar](http://bazaar.canonical.com/).

One of the nice things about distributed verison control is, well,
distributing your code *including its history*.  Sites like
[github](http://github.com) and [bitbucket](http://bitbucket.org) have
become very popular with academics and non-academics for distributing
source and for managing projects.

As an example of how this is has been used, see
[this paper](https://github.com/weecology/data-sharing-paper) by Ethan
White and the ["weecology" lab](http://weecology.org/).  You can see
the whole history of the project, and how different people have
contributed.  In particular, you can see the
[graph](https://github.com/weecology/data-sharing-paper/network) of
how different changes were incorporated by different authors.  This is
a fairly extreme example!

Most of my PhD research is contained within a
[repository on github](https://github.com/richfitz/diversitree) that I
still mantain.  Because this is a project that people have used for a
while, it's nice that the full history is mantained as people can run
analyses against previous versions of the package if their results
change.

Both bitbucket and github offer academic accounts, but require you to
sign up with your university email.

Setting up a project on one of these sites is as easy as:

1. Creating the repository online (click a button prominently
   displayed on the website).
2. Tell your *local* git repository about the presence of a
   repository, with something like `git remote add origin
   git@github.com:usernane/reponame.git`
3. "Push" your content to the website with `git push -u origin master`

There is a bit more to it than that, but if you treat the repository
as "write only" (that is just push changes), you'll just have to do
`git push` to push up all the new commits you've made since last time
you pushed.
