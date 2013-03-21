---
layout: page
title: "Preliminaries"
date: 2013-03-18 17:21
comments: true
sharing: true
footer: false
---

# How this is going to go down

We are going to cover the material in a different way than you would
get taught a statistics course, and a different way than you would get
taught a programming course.

We're going to start pretty slow, and slowly ramp the pace up.  The
idea is to get you to a point where you can continue learning
yourself.  **It is not possible to learn to program in a day**.  It
will take time and practice.  Don't wait until the assignment is due,
or the conference is next week.

If you get lost in the material at the second half of the day, don't
despair.  What we cover in the first half will actually account for
most of what you need to do (apart from statistics and plotting).  If
you get lost in the first half *make sure you speak up*.

We're going to focus on concepts, best practices and workflow almost
as much on getting you going with the syntax and commands.  R is
simply too large to teach in just one day (or the three days that the
full course runs for), and so my main hope is that you get enough of a
flavour of it to continue the learning process yourself.  I probably
have more material here than we'll get through today, and I feel that
this really just scratches the surface.

# Learning R can be frustrating

 - Learning R is not necessarily hard, but not necessarily easy
   either.  Different people will make the logical connections faster
   than others, and until it "clicks" it may seem like a battle.
 - Ask questions as you are unclear and we'll help make those
   connections faster.
 - It is a programming language
   - don't think of it a statistical program that you use from a
     command line
   - think of it as a programming language that happens to have a lot
     of statistical functions.
	 
 - The big challenge is going to be bridging between the nebuluous
   "what I think I want to do" and the precice "computer -- this is
   what I need you to do".
 - It is easy to underestimate how precice instructions need to be.
   We'll see examples, but things like ("take the mean of the leg
   lengths by species" are intuitively obvious to us, but can be hard
   precicely convey to a computer.
    - what if there are missing data?
	- does it matter if there are different numbers individual per
      species?
	- does it matter if there are different sized legs on each species
      (which leg?)
	- what happens if someone gave ranges for some of the leg
      measurements, rather than one number?
	- what about subspecies?

 - There is a good Douglas Adams quote about this: *"If you really
   want to understand something, the best way is to try and explain it
   to someone else. That forces you to sort it out in your mind. And
   the more slow and dim-witted your pupil, the more you have to break
   things down into more and more simple ideas. And that's really the
   essence of programming. By the time you've sorted out a complicated
   idea into little steps that even a stupid machine can deal with,
   you've learned something about it yourself."* (from Dirk Gentley's
   Holistic Detective Agency).

# RStudio

We're going to focus on using RStudio for two reasons:

1. It makes my life easier: you are all using the same tools and we'll
   be able to help you with your problems faster.

2. It will make your life easier: it's got lots of features that help
   people, especially beginners.  It will help you organise your work,
   develop good workflows.  On the other hand, it's not very intrusive
   and if you use a different interface (such as the plain R interface
   that you installed) it will feel very similar.
   
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
    browse) for the parent directory of the project.  By default this
    is probably your home directory, but you might prefer your
    Documents folder.
	
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
there (if you click More: show folder in new window, you'll get a file
browser window opening in about the right place).  Similarly, also
grab [this file](data/seed_root_herbivores.txt) and put it in the
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
