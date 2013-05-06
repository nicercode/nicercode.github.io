---
layout: page
title: "Functions"
date: 2013-04-30 14:08
comments: true
sharing: true
footer: true
---

<!-- ## Goals for this post

1. Understand *why* to move code from in-place into a function.
2. Understand R's function syntax (argument lists, defaults, return
   semantics) and scoping rules.
 -->

Abstracting your code into many small functions is key for writing
nice R code. In our experience, few biologists use functions in their
code. Where people do use functions, they don't use them enough, or
try to make their functions do too much at once.

R has many built in functions, and you can access many more by
installing new packages. So there's no-doubt you already *use*
functions. This guide will show how to *write* your own functions, and
explain why this is helpful for writing nice R code.

Below we briefly introduce function syntax, and then look at how
functions help you to write nice R code. Nice coders with more
experience may want to [skip the first section.](#niceRFunctions)

## Writing your own R functions

Writing functions is simple. Paste the following code into your console

```r
sum.of.squares <- function(x,y) {
  x^2 + y^2
}
``` 

You have now created a function called `sum.of.squares` which requires
two arguments and returns the sum of the squares of these
arguments. Since you ran the code through the console, the function is
now available, like any of the other built-in functions within
R. Running `sum.of.squares(3,4)` will give you the answer `25`.

The procedure for writing any other functions is similar, involving
three key steps:

1. Define the function, 
2. Load the function into the R session,
3. Use the function.

### Defining a function
Functions are defined by code with a specific format:

```
function.name <- function(arg1, arg2, arg3=2, ...) {
  newVar <- sin(arg1) + sin(arg2)  # do Some Useful Stuff
  newVar / arg3   # return value 
}
```

**function.name**: is the function's name. This can be any valid
variable name, but you should avoid using names that are used
elsewhere in R, such as `dir`, `function`, `plot`, etc.

**arg1, arg2, arg3**: these are the `arguments` of the function, also
called `formals`. You can write a function with any number of
arguments. These can be any R object: numbers, strings, arrays, data
frames, of even pointers to other functions; anything that is needed
for the function.name function to run.

Some arguments have default values specified, such as `arg3` in our
example. Arguments without a default **must** have a value supplied
for the function to run. You do not need to provide a value for those
arguments with a default, as the function will use the default value.

**The ‘...’ argument**: The `...`, or ellipsis, element in the
function definition allows for other arguments to be passed into the
function, and passed onto to another function. This technique is often
in plotting, but has uses in many other places.

**Function body**: The function code between the within the `{}`
brackets is run every time the function is called. This code might be
very long or very short.  Ideally functions are short and do just one
thing -- problems are rarely too small to benefit from some
abstraction.  Sometimes a large function is unavoidable, but usually
these can be in turn constructed from a bunch of small functions.
More on that below.

**Return value**: The last line of the code is the value that will be
`returned` by the function. It is not necessary that a function return
anything, for example a function that makes a plot might not return
anything, whereas a function that does a mathematical operation might
return a number, or a list.

### Load the function into the R session

For R to be able to execute your function, it needs first to be read
into memory. This is just like loading a library, until you do it the
functions contained within it cannot be called.

There are two methods for loading functions into the memory:

1. Copy the function text and paste it into the console 
2. Use the `source()` function to load your functions from file.

Our recommendation for writing nice R code is that in most cases, you
should use the second of these options. Put your functions into a file
with an intuitive name, like `plotting-fun.R` and save this file
within the `R` folder in
[your project](http://nicercode.github.io/blog/2013-04-05-projects/). You
can then read the function into memory by calling:

```
source("R/plotting-fun.R")
```

From the point of view of writing nice code, this approach is nice
because it leaves you with an uncluttered analysis script, and a
repository of useful functions that can be loaded into any analysis
script in your project.  It also lets you group related functions
together easily.

### Using your function
 
You can now use the function anywhere in your analysis. In thinking
about how you use functions, consider the following:

- Functions in R can be treated much like any other R object. 
- Functions can be passed as arguments to other functions or returned
  from other functions.
- You can define a function inside of another function.

### A little more on the ellipsis argument

The ellipsis argument `...` is a powerful way of passing an arbitrary
number of functions to a lower level function.  This is how

```
data.frame(a=1, b=2)
```

returns a `data.frame` with two columns and 

```
data.frame(a=1, b=2, c=3)
```

returns a `data.frame` with three columns.

Here's a really daft example.  Suppose you wanted a function that
plots `x`/`y` points in red, but you want all of `plot`'s other
tricks.  You can write the function like this:

```
red.plot <- function(x, y, ...) {
  plot(x, y, col="red", ...)
}
```

and then do

```
red.plot(1:10, 1:10, xlab="My x axis", ylab="My y axis")
```

and your new function will automatically pass the arguments `xlab` and
`ylab` through to plot, even though you never told `red.plot` about
them.

## <a id="niceRFunctions"> What makes for a good function?

### It's short 
<blockquote class="twitter-tweet"><p>If you've written a function whose body is 2,996 lines of code, you're doing it wrong.</p>&mdash; M Butcher (@technosophos) <a href="https://twitter.com/technosophos/status/322392537983746049">April 11, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Performs a single operation

<blockquote class="twitter-tweet"><p>The reason for writing a function is not to reuse its code, but to name the operation it performs.</p>&mdash; Tim Ottinger (@tottinge) <a href="https://twitter.com/tottinge/status/293776089099153408">January 22, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Uses intuitive names

<blockquote class="twitter-tweet"><p>"The name of a variable, function, or class, should answer all the big questions." - Uncle Bob Martin, Clean Code</p>&mdash; Gustavo Rod. Baldera (@gbaldera) <a href="https://twitter.com/gbaldera/status/327063173721100288">April 24, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## How functions help you write Nice R Code

As a reminder, the goal of this course and blog is to help you write nice R code. By that we mean code that is easy to write, is easy to read, runs quickly, gives reliable results, is easy to reuse in new projects, and is easy to share with collaborators. Functions help achieve all of these. 

### Making code more readable

Readability

Consider two short pieces of of code:

```r
data$response.logit <- log(data$response / (1 - data$response))
```

and

```r
logit <- function(p)
  log(p / (1-p))
  
data$response.logit <- logit(data$response)
```

the first is much shorter than the second (1 line vs 3) but it is much
less easy to understand.  You can read the application of the function
as a sentence (`response.logit` is the logit transform of
`data$response`) and you're not bogged down in the detail of how a
logit transformation actually happens.  The second form is also more
reliable than the first, as the variable `data$response` is used only
once -- it would not be possible for the `p` within `logit` to point
at two different variables.

The most important thing that writing functions helps is for you to
concentrate on writing code that describes *what* will happen, not
*how* it will happen.  The *how* becomes an implementation issue that
you don't have to worry about.  

For example, we could define the logit function as

```r
logit <- function(p)
  log(p) - log(1 - p)
```

and our code would still work.

### Avoiding coding errors 

By using functions, you limit the **scope** of variables.  In the
`logit` function, the `p` variable is only valid within the body of
the `logit` function -- it is unaffected by any other variable called
`p` and it does not affect any other variable called `p`.  This means
when you read code you don't have to look elsewhere to reason about
what values variables might take.

Along similar lines, as much as possible functions should be self
contained and not depend on things like global variables (these are
variables you've defined in the main workspace that would show up in
RStudio's object list).
  
### Becoming more productive

Functions enable easy reuse within a project, helping you not to
repeat yourself.  If you see blocks of similar lines of code through
your project, those are usually candidates for being moved into
functions.

If your calculations are performed through a series of functions, then
the project becomes more modular and easier to change.  This is
especially the case for which a particular input always gives a
particular output.

## How long is a piece of string?

In our experience, people seem to think that functions are only needed
when you need to use a piece of code multiple times, or when you have
a really large problem.  However, many functions are actually very
small.

We wrote some code to test 

```r
function.length <- function(f) {
  if ( is.character(f) )
    f <- match.fun(f)
  length(deparse(f))
}

# Filter package objects to just return functions.
package.functions <- function(package) {
  objects <- ls(name=sprintf("package:%s", package))
  is.function <- sapply(objects, function(x) exists(x, mode="function"))
  objects[is.function]
}

package.function.lengths <- function(package)
  sort(sapply(package.functions(package), function.length))
```

```
library(utils)
packages <- rownames(installed.packages())
```

I have 138 packages installed on my computer (mostly through
dependencies).  We need to load them all before we can access the
functions within:

```
for (p in packages)
  library(p, character.only=TRUE)
```

Then we can apply the `package.function.lengths` to each package.

```
lens <- lapply(packages, package.function.lengths)
```

Then plot the distribution of the per-package median (that is, for
each package compute the median function length in terms of lines of
code and plot the distribution of those medians).

```
lens.median <- sapply(lens, median)
hist(lens.median, main="", xlab="Per-package median function length")
```

{% img img/length.png %}

The median package has a median function length of 16 lines.  There
are handful of extremely long functions in most packages; over all
packages, the median "longest function" is 120 lines.

## Concluding thoughts

This material written for coders with limited experience.  Program
design bigger topic than could be covered in a whole course, and we
haven't even begun to scratch the surface here.  Using functions is
just one tool in ensuring that your code will be easy for you to read
in future, but it is an essential tool.

<blockquote class="twitter-tweet"><p>The more I write code, the more abstract it gets. And with more abstractions, the apps are easier to maintain. Been working for years...</p>&mdash; Justin Kimbrell (@justin_kimbrell) <a href="https://twitter.com/justin_kimbrell/status/329054399425019906">April 30, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Further reading

If you want to read more about function syntax, check out the following:

- [The official R intro material on writing your own functions](http://cran.r-project.org/doc/manuals/R-intro.html#Writing-your-own-R-intro.html#Writing-your-own-functions)
- [Our intro to R guide to writing functions](http://nicercode.github.io/intro/writing-functions.html)
  with information for a total beginner
- [Hadley's information on functions](https://github.com/hadley/devtools/wiki/Functions) with information for intermediate and advanced users.


