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

Abstracting your code into many small functions is key for writing nice R code. In our experience, few biologists use functions in their code. Where people do use functions, they don't use them enough. R has many built in functions, and you can access many more by installing new packages. So there's no-doubt you already *use* functions. This guide will show how to *write* your own functions, and explain why this is helpful for writing nice R code. 

Below we briefly introduce function syntax, and then look at how functions help you to write nice R code. Nice coders with more experience may want to [skip the first section.](#niceRFunctions)

## Writing your own R function

Writing functions is simple. Paste the following code into your console

```
sumSquare <- function(x,y){ x^2+y^2 }
``` 

You have now created a function called `sumSquare` which requires two arguments and returns the sum of the squares of these arguments. Since you ran the code through the console, the function is now available, like any of the other built-in functions within R. Running `sumSquare(3,4)` should give you the answer `25`. 

The procedure for writing any other functions is similar, involving three key steps:

1. Define the function, 
2. Load the function into memory,
3. Use the function.

### Defining a function
Functions are defined by code with a specific format:

```
fName <- function(arg1, arg2, arg3=2, ...){
    newVar = sin(arg1) + sin(arg2)  # do Some Useful Stuff
    newVar / arg3   # return value 
}
```

**fName**: is the functions name. This can be anything, but you should avoid using names that are used elsewhere in R, such as `dir`, `function`, `plot`, etc. 

**arg1, arg2, arg3**: these are the `arguments` of the function, also called `formals`. You can write a function with any number of arguments. These can be any R object: numbers, strings, arrays, data frames, of even pointers to other functions; anything that is needed for the *fName* function to run.

Some arguments have default values specified, such as `arg3` in our example. Arguments without a default MUST have a value supplied for the function to run. You do not need to provide a value for those arguments with a default, as the function will use the default value.

**The ‘...’ argument**: The `...` code in the function definition allows for other arguments to be passed into the function, and passed onto to another function. This technique is often in plotting.

**Function body**: The function code between the within the `{}` brackets is run every time the function is called. This code might be very long or very short. It *does not matter* how complex your function is. Small functions are useful, large functions are useful. Although if you have a large function, you would be well-advised to construct it from a bunch of small functions. More on that below.

**Return value**: The last line of the code is the value that will be `returned` by the function. It is not necessary that a function return anything, for example a function that makes a plot might not return anything, whereas a function that does a mathematical operation might return a number, or a list. 

### Load the function into memory
For R to be able to execute your function, it needs first to be read into memory. This is just like loading a library, until you do it the functions contained within it cannot be called.

There are two methods for loading functions into the memory:

1. Copy the function text and paste it into the console 
2. Use the `source()` function to load your functions from file.

Our recommendation for writing nice R code is that in most cases, you should use the second of these options. Put your functions into a file with an intuitive name, like `plotting-fun.R` and save this file within the `R` folder in [your project](http://nicercode.github.io/blog/2013-04-05-projects/). You can then read the function into memory by calling:

```
source("R/plotting-fun.R")
```

From the point of view of writing nice code, this approach is nice because it leaves you with an uncluttered analysis script, and a repository of useful functions that can be loaded into any analysis script in your project.

### Use the function.
 
You can now use the function anywhere in your analysis. In thinking about how you use functions, consider the following:

- Functions in R can be treated much like any other R object. 
- Functions can be passed as arguments to other functions
- You can define a function inside of another function

## <a id="niceRFunctions"> How functions help you write Nice R Code

As a reminder, the goal of this course and blog is to help you write nice R code. By that we mean code that is easy to write, is easy to read, runs quickly, gives reliable results, is easy to reuse in new projects, and is easy to share with collaborators. Functions help achieve all of these. 

### Making code more readable

Readability

- Re-emphasise how this is  the most important part of writing code.
- describe the what not the how -- function names tell you what the
    code *will* do, not the mechanics of *how* it will do it.

Examples of reading a function calling a function.

### Maintaining a clean workspace 
- clean up scope -- more easily reason about the behavior of the program
- global variables and scope

### Avoiding coding errors 
  
  - bugs: avoid scope-related and mutability bugs.  E.g., a global
    variable 'x' that is used in multiple places.
  - DRY 
  
### Becoming more productive

reuse -- within a project DRY. Make you more productive.  Between projects is harder.

easy to plug pieces to together

## Further comments on abstraction and design

This material written for  coders with limited experience. 

Design big topic, much more to cover. Arguably key skill of good software engineers.

## Further reading

If you want to read more about function syntax, check out the following:

- [The official R intro material on writing your own functions](http://cran.r-project.org/doc/manuals/R-intro.html#Writing-your-own-R-intro.html#Writing-your-own-functions)
- [Hadley's information on functions](https://github.com/hadley/devtools/wiki/Functions)

Also include some general references about design and abstraction


