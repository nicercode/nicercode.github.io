---
layout: post
title: "Organizing the project directory"
author: Marcela Diaz
date: 2013-05-17 08:20
comments: true
publish: true
categories: project guest module 2013-MQ
---

This is a guest post by Marcela Diaz, a PhD student at Macquarie University. 

Until recently, I hadn't given much attention to organising files in my project. All the documents and files from my current project were spread out in two different folders, with very little sub folder division. All the files where together in the same place and I had multiple versions of the same file, with different dates. As you can see, things were getting a bit out of control.

<!--more -->
{% img ../../images/2013-05-17-organising-my-project/directory1_before.png %}

{% img ../../images/2013-05-17-organising-my-project/directory2_before.png %}

Following [advice from by Rich and Daniel](../2013-04-05-projects/), I decided to spend a little time getting organised, adopting a directory layout with the following folders:

- Data: which contains both my base (raw) data and the processed data 
- Output: data and figures generated in R
- R: R scripts with all new functions I created as part of the cleaning directory process and in an attempt to write nicer code. 
- Analysis (R file): R script sourcing all the functions necessary for the analysis 

{% img ../../images/2013-05-17-organising-my-project/directory_after.png %}

At the same time I [started using version control with git](../../git). As a result, I no longer need to create a new file every time I make a change, and each of the files in the analysis directory is unique.

Setting up the new directory and sorting the existing files in the new folders didn't take long and was relatively easy. Now it is really simple to find files and keep track of current and old figures. I no longer need to use spotlight to find the latest version of each script. From my experience this improved the organization and efficiency of my project; I  highly recommend keeping a good project layout. 
