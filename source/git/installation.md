---
layout: page
title: "Installing git"
date: 2013-04-16 09:00
comments: true
sharing: true
footer: false
---

Installing git should be fairly straightforward on most platforms.

* Go to the git homepage, [git-scm.com](http://git-scm.com)
* Download the current version (release at time of writing is
  1.8.2.1).  By default, it should offer you the correct version for
  your operating system.
  
### For Windows:

* Run the downloaded "exe" file; the installer is a typical windows
  one -- accept the licence (GNU GPL).  The default options for the
  "Select components" window should be good for everyone.  In
  particular, the "Advanced context menu (git-cheetah plugin)" under
  "Windows Explorer integration" should be selected.  It's up to you
  if you want icons peppered around as Windows likes to do.
* When prompted about "Adjusting your PATH environment", select the
  **second option (Run Git from the Windows Command Prompt)**.  This
  will help RStudio find git and save a step later.
* Accept the default for line endings; there is no joy to be had here,
  but this is probably the least bad option.

### For Mac:

* Open the downloaded "dmg" file.
* Run the installer "pkg" contained within.  On Mountain Lion, you may
  have to hold down Command and Control when you click, and select
  open to work around the increased security "features".
* There are no useful options, so just click OK through the
  installation.

## Testing that the installation works

For **Windows**, git will have installed something called "Git Bash"
on your computer.  This is not a game about assaulting annoying people.
Open this (could be an icon on the desktop, could be in the start
menu).

For **Mac**, open the terminal (either type terminal in spotlight and
click the result from "Applications", or in finder go to Applications:
Utilities: Terminal).

At the command line that appears, type `git version` and press enter.
You should see something similar to

```
git version 1.9.1.msysgit.1
```

RStudio has integration with git.  Open Rstudio and go to the options
pane (**Windows** users, look in Tools: Options, **Mac** users, look
in RStudio: Preferences).  The last entry in the ribbon on the left is
"Git/SVN".  Select that, and look at the contents of the box saying
"Git executable".  It should say something like `C:/Program Files
(x86)/Git/bin/git.exe` (**Windows**) or `/usr/bin/git` (**Mac**).  If
instead it says `(Not found)`, RStudio cannot find git.  

If RStudio cannot find git (and testing `git version` on the command
line worked above), then click the "Browse..." button and navigate to
the path (**Windows** users on some platforms should use `C:/Program
Files/Git/bin/git.exe`).
