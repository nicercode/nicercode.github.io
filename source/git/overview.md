---
layout: page
title: "Git overview"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Essentially, all version control does is store snapshots of your work
in time, and keeps track of the parent-child relationships.

{% imgcap /git/img/git-intro-history.png From [Pro Git](http://git-scm.com/book/en/Getting-Started-Git-Basics) %}

You can think of your current set of working files as simply the
child of the last node in this chain (that is, your files are the
children of the most recent set of files known to the version control
system).

`git` provides a large number of tools for manipulating this history.
We'll only touch on a few, but the number that you need to know for
day-to-day use is actually quite small.

First, we're going to need some terminology:

* **Repository**: "Repo" for short; this is a copy of the history of
  your project.  It is **stored in a hidden directory within your
    project**.  People will talk about "cloning a repo" or "adding things
  to a repo"; these all manipulate the history in some way.
* **Working directory**: This is your copy of a project.  It's just a
  directory with files and other directories in it.  The repository is
  contained within a `.git` directory at the root directory of your
  project.

One of the distinguishing and great features about git is that the 
repo contains the entire history of the project, i.e. if your project
moves, the history travels with it. So if you clone your work to a 
new computer, or a collaborator gets involved (more on
how to do that later), they have the full project history available. 
This is called [distributed version control](en.wikipedia.org/wiki/
Distributed_revision_control).

## What goes in my repository? 

You should establish a new repo for each project you are working on. As we 
[discussed previously](http://nicercode.github.io/blog/2013-04-05-projects/)) 
the project folder should contain everything related to a particular project, 
including inputs (data, images, notes), analysis scripts and outputs (figures, 
tables.) The content of your project will evolve over time and this will be tracked 
within the git repo. 

But not all of your project folder contents will be stored within the git 
system. As a general guide, we suggest you make a folder called outputs. This is 
where you should save figures and other outputs from your analysis scripts. These 
outputs do not need to be tracked, as they can be reproduced at any time by 
rerunning the script. Later we'll show you how to `ignore` certain files in git. 

## The commit cycle

Your project develops as you do work. During this process you make a series of 
small changes such as

- writing some code 
- importing/entering  new data
- reorganising your files
- making a figure
- writing bits of reports or papers.

The idea with git is that you break up your project activity into a series of small 
tasks, each corresponding to a 'commit'. So the cycle goes 

> Checkout project --> do work --> review changes --> commit

Anecdotal evidence suggests experienced programmers break up their project into 
lots of small pieces, and have lots of commits in their work cycle, while novices 
tend to have fewer, larger commits. some of the advantages of small commits are

- helps you to focus on one small piece of a much larger puzzle
- it's easier to recover if something goes wrong
- you have a greater sense of achievement. 

In the [software carpentry](http://software-carpentry.org/) module we attended, Greg 
Wilson suggested we aim for work cycle of about 1 hr.
 
You should aim to only commit once a piece of code works, so that you leave your code in 
working order. Thus

{% blockquote Karthik Ram http://www.scfbm.org/content/8/1/7/abstract Source Code for Biology and Medicine 8:7 %}
Commits serve as checkpoints where individual files or an entire project can be safely reverted to when necessary.
{% endblockquote %}
