---
layout: page
title: "Preliminaries"
date: 2013-03-18 17:21
comments: true
sharing: true
footer: true
---

## How this is going to go down

I'm going to present the material here in a different way than you
would get taught a statistics course, and a different way than you
would get taught a programming course.

We're going to start pretty slow, and slowly ramp it up.  The idea is
to get you to a point where you can continue learning yourself.  **It
is not possible to learn to program in a day**.  It will take time and
practice.  Don't wait until the assignment is due, or the conference
is next week.

If you get lost in the material at the second half of the day, don't
despair.  What we cover in the first half will actually account for
most of what you need to do (apart from statistics and plotting).  If
you get lost in the first half *make sure you speak up*.

We're going to focus on best practices and workflow just as much on
getting you going with the syntax and commands.  R is simply too large
to teach in just one day (or the three days that the full course runs
for), and so my main hope is that you get enough of a flavour of it to
continue the learning process.  I probably have more material here
than we'll get through today, and I feel that this really just
scratches the surface.

We're going to focus on using RStudio for two reasons:

1. It makes my life easier: you are all using the same tools and we'll
   be able to help you with your problems faster.

2. It will make your life easier: it's got lots of features that help
   people, especially beginners.  It will help you organise your work,
   develop good work flows.  On the other hand, it's not very
   intrusive and if you use a different interface (such as the plain R
   interface that you installed) it will feel very similar.
   
## Getting started with RStudio

Load R studio however you do that on your platform.

RStudio has four panes:

1. Bottom left -- this is the R interpreter.  If you type
   code here, it is "evaulated" so that you get an answer.
2. Top left -- editor for writing longer pieces of code.
3. Top right will tell you things about objects in the workspace.
   We'll get to this soon, but this will be things like data objects,
   or functions that will process them.  It is completely unrelated to
   the file system. The "History" tab will keep an eye on what you've
   done.
4. Will display files, plots, packages, and help information, usually
   as needed.

We'll do everything in a project, as that will help when we get some
data.

  - "Project": "Create Project..."
  - choose "New Project, (start a project in a new directory)".
  - Leave the "Type" as the default.
  - In the "Directory name" type the name for the project (in our case
    `g2g` might be a good name).
  - In the "Create project as a subdirectory of" field select (type or
    browse) for the parent directory of the project.  By default your
    home, but Documents might be better.
	
The RStudio window morphs around a bit, and the top left pane will
disappear.

In the bottom right panel, make sure that the "Files" tab is selected
and make a new folder called `data`.  I strongly recommend keeping a
directory like this in every project that contains your data.  Treat
it read only (that is, write once, then basically don't change).  This
may be a large shift in thinking if you've come from doing data
analysis and management in Excel.

In more complicated projects, I would generally have a folder called
`R` that contains scripts and function definitions, another called
`figs` that contained figures that I've generated, and one called
`doc` that contains the manuscript, talks, etc.

We're going to spend a bit of time using a data set.  You can download
this from [here](data/seed_root_herbivores.csv) and put it into that
directory.  Download this file, open the `g2g/data` folder and move it
there (if you clock More: show folder in new window, you'll get a file
browser window opening in about the right place).  Similarly, also
grab [this file](data/seed_root_herbivores.csv) and put it in the
`data` directory too.

To make sure everything is working properly, in the console window
type

```r
file.exists("data/seed_root_herbivores.csv")
```

which should print

```plain
[1] TRUE
```

---
Back to [main page](/intro)
