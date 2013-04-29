

# Post #

## markdown editors

http://markable.in/
http://www.sublimetext.com/

knitr in Rstudio

slidify
shiny - interactive plots

Markdown in science

- tutorial: https://github.com/karthikram/markdown_science

## Issues setting root directory in knitr
Setting the root.dir option might help:
  http://yihui.name/knitr/options
Not sure where that gets set, or how you'd set it on a per-project basis.

That said, if the script that requires the path is also in the analysis/ directory, then you could probably just code in the path relative to that directory and things are clear.  If it's in the project root directory, then you probably want it to be more flexible as you don't know where it would be used from.

One thing that might help is this:

find.project.root <- function(path=".", relative=TRUE) {
  if ( file.exists(file.path(path, ".git")) ) {
    if (relative) path else normalizePath(path)
  } else {
    Recall(if (path==".") ".." else file.path(path, ".."), relative)
  }
}

It will recursively search up the tree until it finds a .git directory, and give you the absolute or relative path to it.  You could write a similar one that used the Rproj file (the first test would look like this:
  length(dir(path, "^.*\\.Rproj$)) > 0

This would give you the bit that you would need to pass to a function that depended on paths.


