--- 
layout: page 
title: "Repeating things: looping and the apply family" 
date: 2013-03-18 10:25 
comments: true 
sharing: true 
footer: false 
---

Previously we looked at how you can [use functions to simplify your 
code](../functions/). Ideally you have a function that performs a single
opertaion, and now you want to use it many times to do the same operation on lots of different data.
The naive way to do that would be something like this:
  
```{r}
  res1 <-  f(input1)
  res2 <-  f(input2)
  ...
  res10 <-  f(input10)
```

But this isn't very *nice*. Yes, by using a function, you have reduced a
substantial amount of repetition. That IS nice. But there is still repetition. Repeating yourself will cost you time, both now and later, and potentially introduce some nasty  bugs. When it comes to repetition, well, just don't.

The nice way of repeating elements of code is to use a loop of some sort. A  loop is a coding structure that reruns the same bit of code over and  over, but
with only small fragments differing between runs. In R there  is a whole
family of looping functions, each with their own strengths.

# The split--apply--combine pattern

First, it is good to recognise that most operations that involve looping are instances of the *split apply combine* strategy. You start with a bunch of data. Then you then **Split** it up into many smaller datasets, **Apply** a function to each piece, and finally **Combine** the results back together.

Some data arrives already in its pieces - e.g. output files from from a leaf scanner or temperature machine. Your job is then to analyse each bit, and put them together into a larger data set.

Sometimes the combine phase means making a new data frame, other times it might mean something more abstract, like combining a bunch of plots in a report. 

Either way, the challenge for you is to identify the pieces that remain the same between different runs of your function, then structure your analysis around that.

# Why we're not starting with `for` loops 

Ok, you got me, we are starting with for loops. But not in the way you think.

When you mention looping, many people immediately reach for `for`. Perhaps that's because, like me, they are already familiar with these other languages, like basic, python, perl, C, C++ or matlab. While `for` is definitely the most flexible of the looping options, we suggest you avoid it wherever you can, for the following two reasons:

1. It is not very expressive, i.e. takes a lot of code to do what you want.  
2. It permits you to write horrible code, like this example from my earlier work:

```{r}
  for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(5,5,5, 2), mar=c(3, 0, 0, 0));
    for(i in 1:I)
        {   
        Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])   
        Y_ax =seq(0, 35, 10); Y_ax2=seq(0, 35, 5);
        X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1); 
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1)
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
        axis(4, at=Y_ax, labels=F,  tck=0.03)
      
        X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1]))      
        
        Y<-Dat$S2AV_L;
        points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col= Fig$Cols[2]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[2], lty = "dotted")
 
        legend("topright", legend = paste("indiv = ",Ind[i]), bty= "n")  
       }
   mtext(expression(paste("Intercepted light (mol ", m^{-2},d^{-1},")")), side = 2, line = 3, outer = T, adj = 0.5, cex =1.2)
   mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0.2, outer = T, adj = 0.5, cex =1.2)
   mtext(as.character(sp.list$Species[n]), side = 3, line = 2, outer = T, adj = 0.5, cex =1.5)
   }
rm(R, Ind, I, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat)
```

The main two problems with this code are that

- it is hard to read
- all the variables are stored in the global scope, which is dangerous.

Compare that to something like this

```{r}
  lapply(unique(Raw$SPP), makePlot, data = Raw)
```
That's much nicer! It's obvious what the loop does, and no new variables are created. Of course, for the code to work, we need to define the function 

```{r}
makePlot <- function(species, data){
  ... #do stuff
}
```
which actually makes our plot, but having all that detail off in a function has many benefits. Most of all it makes your code more reliable and easier to read. 

So our reason for avoiding for, is that the other looping functions, like lapply, demand that you write nicer code, so that's we'll focus on first.

# The apply family

There are several related function in R which allow you to apply some function to a series of objects (eg. dataframes). They include:

- lapply
- sapply
- tapply
- aggregate
- mapply
- apply.

Each repeats a function or operation on a series of elements, but they differ in the data types they accept and return. What they all in common is that **order of operation is not important**, i.e. each operation is independent.

# lapply()

`lapply` applies a function to each element of a list (or vector), collecting results in a list. (If you don't know what a list is, see  ??? ).

## Basic syntax

```{r}
result <- lapply(X, f, ...)
```

Here `X` is a list or vector, containing the elements that form the input to the function `f`. For example, below we use lapply to ..... for a series of....

```{r}
result <- lapply(X, )
```

## Tricks

The most trick for using lapply is to understand how to use lists. List are enormously flexible and powerful. To access elements of a list, you use the double square bracket, for example `X[[4]]` returns the fourth element of the list. 

Another trick is using output. 

use do.call(rbind) to combining together

Also sapply:  - sapply --> vector, matrix


## Where it shines

lapply is great for building analysis pipelines, where you want to repeat a series of steps on a large number of similar objects.  The way to do this is to have a series of lapply statements, with the ouput of one providing the input to another. 

Another great feature of lapply is that is makes it really easy to parallelise your code. all more computers contain multiple CPUs, and these can all be put to work using the great multicore package   

```{r}
library(multicore)
result1 <- lapply()
result2 <- mclapply()
```

## Limitations

In principle, only one item can differ between different function calls, a feature that some might see as a limitation. However, it is easy to get around this. For example, let's say 

  - additional arguments:
    - wanted to see original data and sub-setted data
    - f(level, data)
    - lapply(unique(level), f, data))

    - lapply(v,f,extra) --> this first (extra = options for plot, null hypoth value to test, other common options, stringsAsFactors=FALSE for csv files) 


# tapply
 "compute summary statistics for some response variable grouped by grouping variable, returning a vector, list or matrix"
  - means by 1 -factor

# aggregate 

" wrapper around tappply to make results more useful especially for multiway groupings"
  - means by 2 -factor
  - examples: moniques data problem

# apply 

# for loops

- "good for functions that depend on outcomes from earlier iterations"
 very flexible
- if written well, can be similar to lapply

: Random walk

# while (and repeat)
- use where 

