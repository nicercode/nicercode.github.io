

# Post #



# Teaching material #



Some notes from ["Best practices in writing packages" page](https://github.com/ropensci/rOpenSci/wiki/Best-practices-in-writing-packages) on ropensci website (by cboettig)

The Writing R Extensions manual is great, but not exactly bedside reading. The check tool does an excellent job, but several annoying practices slip through. Here are a few that most frequently frustrate me.

    Use message() and warning() to communicate with user in your functions. Please do not use print()
    Use INCLUDE instead of DEPENDS for packages providing functions you use internally only.
    Use a NAMESPACE instead of exporting all your internal functions.
    Consider following an R style guide, or formatR
    Include examples in the documentation. (Provide working illustrations and act as a poor man's unit test).
    When calling another function internally, such as optim(), pass all the function options up to the user as options with defaults, rather than hard-coding in a certain choice, such as the method for optimization.
    Consider roxygen documentation for R functions.
    Consider version management repository like rforge or github.
    Devtools package and it's wiki are an excellent resource.
