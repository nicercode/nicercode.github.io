---
layout: post
title: "Excel and line endings"
date: 2013-04-04 09:39
comments: true
categories: 
---

On a Mac, Excel produces csv files with the wrong line endings, which
causes problems for git (amongst other things).

This issue plagues at least
[Excel 2008](http://developmentality.wordpress.com/2010/12/06/excel-2008-for-macs-csv-bug/)
and 2011, and possibly other versions.

Basically, saving a file as comma separated values (csv) uses a
carriage return `\r` rather than a line feed `\n` as a newline.  Way
back before OS X, this was actually the correct Mac file ending, but
after the move to be more unix-y, the correct line ending should be
`\n`.

<!-- more -->

Given that nothing has used this as the proper line endings for over a
decade, this is a bug.  It's a real pity that Microsoft does not see
fit to fix it.

## Why this is a problem

This breaks a number of scripts that require specific line endings.

This also causes problems when version controlling your data.  In
particular, tools like `git diff` basically stop working as they work
line-by-line and see only one long line
(e.g. [here](http://stackoverflow.com/questions/11531084/strange-git-line-ending-issue)).
Not having `diff` work properly makes it really hard to see where
changes have occurred in your data.

Git has really nice facilities for translating between different line
endings -- in particular between Windows and Unix/(new) Mac endings.
However, they do basically nothing with old-style Mac endings because
*no sane application should create them*.  See
[here](https://github.com/git/git/blob/master/convert.c#L93), for
example.

## A solution
There are at leat two stack overflow questions that deal with this 
([1](http://stackoverflow.com/questions/10491564/git-and-cr-vs-lf-but-not-crlf?rq=1)
and
([2](http://stackoverflow.com/questions/11531084/strange-git-line-ending-issue)).

The solution is to edit `.git/config` (within your repository) to add
lines saying:

```
[filter "cr"]
    clean = LC_CTYPE=C awk '{printf(\"%s\\n\", $0)}' | LC_CTYPE=C tr '\\r' '\\n'
    smudge = tr '\\n' '\\r'
```

and then create a file `.gitattributes` that contains the line

```
*.csv filter=cr
```

This translates the line endings on import and back again on export
(so you never change your working file).  Things like `git diff` use
the "clean" version, and so magically start working again.

While the `.gitattributes` file can be (and should be) put under
version control, the `.git/config` file needs to be set up separately
on *every clone*.  There are good reasons for this (see
[here](http://stackoverflow.com/questions/6547933/is-it-possible-to-clone-git-config-from-remote-location).
It would be possible to automate this to some degree with the
`--config` argument to `git clone`, but that's still basically manual.

## Issues

This seems to generally work, but twice in use large numbers of files
have been marked as changed when the filter got out-of-sync.  We never
worked out what caused this, but one possible culprit seems to be
[Dropbox](http://www.dropbox.com) (but you probably should not keep
repositories on dropbox anyway).

## Alternative solutions

The nice thing about the clean/smudge solution is that it leaves files
in the working directory unmodified.  An alternative approach would be
to set up a pre-commit-hook that ran csv files through a similar
filter.  This will modify the contents of the working directory (and
may require reloading the files in Excel) but from that point on the
file will have proper line endings.

More manually, if files are saved as "Windows comma separated (.csv)"
you will get windows-style line endings (`\r\n`) which are at least
treated properly by git and are in common usage this century.
However, this requires more remembering and makes saving csv files
from Excel even more tricky than normal.
