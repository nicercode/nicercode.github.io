---
layout: page
title: "Why use version control"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

I'm using "ecologists" as a shorthand here.  It's not an exclusive
term -- many geneticists or other scientists will do the same thing,
or have the same needs.

> Version control systems (VCS), which have long been used to maintain code repositories in the software industry, are now finding new applications in science. One such open source VCS, git, provides a lightweight yet robust framework that is ideal for managing the full suite of research outputs such as datasets, statistical code, figures, lab notes, and manuscripts. 
> -- Karthik Ram, Source Code for Biology and Medicine 8:7 

<blockquote class="twitter-tweet"><p>“GitHub has empowered a new generation of people to collaborate, create, produce.” <a href="http://t.co/aSbXZBXHkW" title="http://bit.ly/13JH7VL">bit.ly/13JH7VL</a></p>&mdash; Karthik Ram (@_inundata) <a href="https://twitter.com/_inundata/status/309812088103137281">March 7, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p>Contributed my first bit of code to a git repo yesterday, I love it! <a href="https://t.co/9FU2Yuxi" title="https://github.com/mexitek/phpColors">github.com/mexitek/phpCol…</a> @<a href="https://twitter.com/github">github</a> @<a href="https://twitter.com/mexitek">mexitek</a></p>&mdash; Daniel Pataki (@danielpataki) <a href="https://twitter.com/danielpataki/status/302812382298779648">February 16, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p>Even if git isn't your flavor, you gotta love <a href="https://gist.github.com/">https://gist.github.com/</a> - posting code snippets that other people can fork is beautiful.</p>&mdash; Jon Galloway (@jongalloway) <a href="https://twitter.com/jongalloway/status/72932987511128064">May 24, 2011</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p>Welcome to a New Gist: At GitHub we love using Gist to share code. Whether it's a simple snippet or... <a href="http://t.co/vq8UN8jB" title="http://bit.ly/Ug12CC">bit.ly/Ug12CC</a> <a href="https://twitter.com/search/%23github">#github</a> <a href="https://twitter.com/search/%23git">#git</a></p>&mdash; Pablo Rodriguez (@derfarg) <a href="https://twitter.com/derfarg/status/278621287583207424">December 11, 2012</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
https://github.com/blog/1276-welcome-to-a-new-gist

http://blogs.biomedcentral.com/bmcblog/2013/02/28/version-control-for-scientific-research/

Resources: 

- Books: Git pro and [Git succintly](http://www.syncfusion.com/resources/techportal/ebooks/git)
- 

<blockquote class="twitter-tweet"><p>Rstudio has super simple point-and-click version control (via git) baked in for "projects". No excuses for not using it! (via @<a href="https://twitter.com/danmcglinn">danmcglinn</a>)</p>&mdash; Rich FitzJohn (@phylorich) <a href="https://twitter.com/phylorich/status/301107009573490688">February 11, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p>Coders - use version control, it rocks. Big thanks to @<a href="https://twitter.com/phylorich">phylorich</a> for introducing me to git. Starter's guide: <a href="http://t.co/LFtHf1pX" title="http://git-scm.com/book/en/Getting-Started-About-Version-Control">git-scm.com/book/en/Gettin…</a></p>&mdash; Daniel Falster (@adaptive_plant) <a href="https://twitter.com/adaptive_plant/status/267855974637920257">November 12, 2012</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## You are already using version control

* Commented out bits of code / text
* Files with numbers afterwards (`thesis_v1.doc`, `thesis_v2.doc`,
  `thesis_final.doc`, `thesis_final2.doc`, etc)
* Zip up the whole project directory every so often and save it with
  the date appended to the filename.
  
[PhD comic](http://www.phdcomics.com/comics/archive.php?comicid=1531)
  
Most ecologists seem to invent at least one of these techniques for
doing version control
  
In addition, you'll often see people suggesting putting headers like
this in your code file:

```
  ## My file (c) Rich FitzJohn
  ## Created: 2012/10/04
  ## Modified: 2013/04/04
```

Sometimes you'll even see changelogs embedded in these.

The problem with this is that it's repetitive and boring, it's
difficult to extract the information easily (e.g., get me all the
files **I** modified in the last month), there is no checking on the
contents of the fields (dates in the future, forgetting to update
dates, inconsistent names, email addresses).  The *point* of these
headers is nice --- keep track of who did what and when, but this is
far easier to do with version control.

Commented out old bits of code.

## Why use version control?

There are many reasons to use version control, and many are only
apparent after you have incorporated it into your workflow (it's a bit
like "why use R" or "why document your code").  However, there is a
set of advantages that are very common.

Most of these revolve around the fossil record in your code.  This is
a series of revisions that connect to each other between the present
and the first piece of code you wrote.  Be able to go back to previous
versions of your code, and see what you did.  This has numerous use
cases:

1. You noticed that your code is doing odd things now and didn't used
to.  Look at and run a version from the last known good code and try
to work out what changed (after this, you should write a unit test --
in a couple of weeks).

2. You deleted some code and want to get it back.  This has a less
obvious, but much more common (and perhaps more important) advantge;
you will be more likely to delete old code rather than commenting it
out, leaving you with shorter, more readable scripts.

3. You want to show your supervisor what you did last week.

4. Inversely, on a collaborative project, see what your collaborators
wrote last week.

5. You reformatted everything from numbered citation styles to
author-year after being rejected from journal A and sending your paper
to journal B.  Journal B didn't want the paper anyway, so you can get
the previous version back.

6. You want to experiment and try something that might break huge
pieces of your project, and know that you can back out if things go
awry.

7. Similarly, you want to try a couple of different strategies for
solving a problem and review which one you like best (or show them to
someone else).

8. Gives you an auditable project history; you know when you did what
you did.

## Version control is not a back up

It appears that this is like a brilliant backup system, but you need a
backup too.  Backing up is a complementary set of functions that
overlap only in that there is usually some history going back.

* Back up but not git: corruption of repository, generated files that
  are not part of a repository but time consuming, installed software
  and other system issues.  It is possible (but often hard) to break
  your git repository; you might reclone from somewhere or you might
  grab the last copy of a backup.  Backup systems usually have larger
  capacity than online version control systems.

* Git but not backup: semantics around files, parallel branched
  versions of files, check out by either checkpoint or time (not just
  last time, etc).

In general, you need both.  I have all my projects under version
control, and my whole documents directory under backup.  If my
computer fails, I immediately copy my documents directory from the
backup to a new computer.  I only need to get the last version though.
On the other hand, at any time I can easily look back through the
history of any project and see the work.  For some projects, the last
modification was months ago, while most backup system will be
seriously thinning by this point (moving to monthly snapshots at best,
and you probably have to pay for that).
