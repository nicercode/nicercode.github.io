---
layout: post
title: "Why nice code"
date: 2013-04-05 14:46
comments: true
categories: 
publish: false
author: Daniel Falster

---

<!-- 
Why are students here
Goals: performance, learning, affective, social
Value: attainment, intrinsic, instrumental 

Instrumental - allows you to accomplish other important goals (extrinsic rewards), i.e. learn about world, write papers, impress others
Intrinsic - value nice code for itself (craftsmanship)
Attainment -  satisfaction in getting something to work
-->

# Why nicer code

Writing code is fast becoming a key - if not the most important - skill for doing research in the 21st century. As scientists, we live in extraordinary times. The 
amount of data (information) available to us is increasingly exponentially, allowing for rapid advances in our understanding of the world around us. The amount of information contained in a standard scientific paper also seems to be on the rise. Researchers therefore need to be able to handle ever larger amounts of data to ask novel questions and get papers published. Yet, the standard tools used by many biologists -  point and click programs for manipulating data, doing stats and making plots - do not allow us to scale-up our research, at least not without many, many more 'clicks'. The solution is to write scripts in programs like [R](www.r-project.org/), [python](http://www.python.org/) or [matlab](http://www.mathworks.com.au/products/matlab/). Scripting allows you to automate analyses, and therefore [scale-up without a big increase in effort](http://i.imgur.com/SbzNW8s.png).  Writing code also offers other benefits beneficial to research. When your analyses are documented in a script, it is easier to pick up a project and start working on it again. You have a record of what you did and why. Chunks of code can also be reused in new projects, saving vast amount of time. Writing code also allows for effective collaboration with people from all over the world. For all these reasons, many researchers are now learning how to write code.

Yet, most researchers have no or limited formal training in computer science, and thus struggle to write nice code. Most of us are self-taught, having used a mix of books, advice from other amateur coders, internet posts, and lots of trial and error. Soon after have we written our first R script, our hard drives explode with large bodies of barely readable code that we only half understand, that also happens to be full of bugs and is generally difficult to use. Not surprisingly, many researchers find writing code to be a relatively painful process, involving lots of trial and error and, inevitably, frustration. If this sounds familiar to you, don't worry, you are not alone. There are many [great R resources](link to R resource page) available, but most show you how to do some fancy trick, e.g. run some complicated statistical test or make a fancy plot. Few people - outside of computer science departments - spend time discussing the qualities of nice code and teaching you good coding habits. Certainly no one is teaching you these skills in your standard biology research department.

Realising this, we ([Rich FitzJohn](http://www.zoology.ubc.ca/~fitzjohn/) and [Daniel Falster](http://www.falsters.net/daniel)) have teamed up to bring you the [nice R code](http://nicercode.github.io/) course and blog. We are targeting researchers who are already using R and want to take their coding to the next level. Our goal is to help you write nicer code. By 'nicer' we mean code that is easy to read, easy to write, runs fast, gives reliable results, is easy to reuse in new projects, and is easy to share with collaborators. We will be focussing on elements of workflow, good coding habits and some tricks, that will help transform your code from ugly to nice.

The inspiration for nice R code came in part from attending a boot camp run by Greg Wilson from the [software carpentry team](http://software-carpentry.org/). These boot camps aim to help researchers be more productive by teaching them basic computing skills. Unlike other software courses we had attended, the focus in the boot camps was on good programming habits and design. As biologists, we saw a need for more material focussed on R, the language that has come to dominate biological research.

## Key elements of nice R code
We will now briefly consider some of the key principles of writing nice code. 

### Nice code is easy to read

> Programs should be written for people to read, and only incidentally for machines to execute.
> -- from "Structure and Interpretation of Computer Programs" by Abelson and Sussman

By far the most important guiding principle for writing nicer code is that it should be easy to read. Anyone should be able to look at any of your scripts and understand what it does and how to run it. In most biological research this is anything but the case. Researchers are primarily interested in writing scientific papers, so spend most of their time getting their code to run, and almost no time focussing on the quality of the code itself. Along the way we might take a number of shortcuts, telling ourselves that it doesn't matter, as long as it runs, right? Well if you need motivation, consider this  

> Always code as if the person who will maintain your code is a maniac serial killer that knows where you live

This might sound extreme, until you realise that the maniac serial killer is **you**, and they definitely know where you live. At some point, you will return to nearly every piece of code you wrote and need to understand it afresh. If it is ugly code, you will spend a lot of time going over it to understand what you did, possibly a week, month, year or decade ago. Although you are unlikely get so frustrated as to seek bloody revenge on your former self, you might come close. The single biggest reason you should write nice code is so that your future self can understand it. 

As a by product, we also note that code that is easy to read is also easy to reuse in new projects and share with colleagues, including as online supplementary material. Increasingly, journals are requiring code be submitted as part of the review process and often published online. Alas, much of the current crop of code is difficult to read. At best, having ugly code may reduce the impact of your paper, at worst, your paper might get rejected because the reviewer can't understand your code.

Writing readable code requires that  many features that we hope to cover:

- use of good variable names
- intent (what is it meant to do) --> variable names, comments, design
- style
- don't repeat yourself 
- version control

### Nice code is reliable, i.e. bug free

- don't repeat yourself, avoiding repetition makes code more reliable
- testing scripts
- global vars
- version control
[Code smell](http://en.wikipedia.org/wiki/Code_smell): any symptom in the source code of a program that possibly indicates a deeper problem

### Nice code runs quickly and is therefore a pleasure to use

- waiting days


## Why you need to write nicer code

There is a common perception among scientists we have talked with that provided the code "runs", it doesn't need to be nice. 

Why: 

- **Better science**
- **More fun**: spend less time wrestling with R, enjoyment of scientific process. nice code is more fun
- **Bigger datasets**: allows you to scale up. Repetition is avoidable, which it isn't in field or lab- ever decreasing cost of more data, compared to linear cost with bad code/ excel. 

- **Become more efficient**:  reusable, sharable. shortcut now is mortgage on your future time
- **Future employment**: Impact. Code itself is **you should consider anything you write (open or closed) to be a potential advert to a future employer**. [Scientists and engineers with an analytical bent are sought-after in natural-hazard risk assessment" in natural-hazard risk assessment](http://www.nature.com/naturejobs/science/articles/10.1038/nj7440-271a)

 - [Don't worry about code snobs](www.software.ac.uk/blog/2013-01-25-haters-gonna-hate-why-you-shouldnt-be-ashamed-releasing-your-code) 


# Showcase #

github, twitter API
Hadley Wickham, large data
diversitree on github

- network via history, Emma Goldberg fork

Poor code: Freckleton MEE http://dx.doi.org/10.1111/j.2041-210X.2012.00220.x

- sI material does not work




