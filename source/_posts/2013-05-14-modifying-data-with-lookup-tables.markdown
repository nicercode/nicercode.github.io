---
layout: post
title: "Modifying data with lookup tables"
author: Daniel Falster
date: 2013-05-14 08:20
comments: true
publish: true
categories: 
---

<!-- The problem:
- importing new data
- amount of code to be written (opportunities for mistake)
- separating data from scripts
- maintaining record of where data came from

Common approach
- long sequence of data modifying code

Solution
- use lookup table, find and replace
 -->

In nearly all analyses, we read data from a file. But often that data needs to be modified before it can be used. For example you may want to add a new column of data, or do a "find" and "replace" on a site, treatment or species name. There are 3 ways one might add information. The first involves editing the original data frame -- you should *never* do this. The second -- and possibly most common -- way of adding information is to write some code to modify the values. The third -- and nicest -- way of adding information is to use a lookup table. 

<!-- more -->

One of the most common things we see in the code of researchers working with data are long slabs of code modifying a data frame based on some logical tests. Such code might correct a species name:
```r
raw$Tree[raw$Tree=="E. regnans"]       <-  "Eucalyptus regnans"  
raw$Tree[raw$Tree=="S. sempervirens"]  <-  "Sequoia sempervirens"
```

or add some site details
```r
raw$location[raw$Tree=="Eucalyptus regnans"]      <-  "Wallaby Creek, Kinglake National Park, Victoria, Australia"
raw$location[raw$Tree=="Sequoia sempervirens"]    <-  "Bull Creek, Humboldt Redwoods State Park, California, USA"
raw$latitude[raw$Tree=="Eucalyptus regnans"]      <-  -37
raw$latitude[raw$Tree=="Sequoia sempervirens"]    <-  145
raw$longitude[raw$Tree=="Eucalyptus regnans"]     <-  40
raw$longitude[raw$Tree=="Sequoia sempervirens"]   <-  -124
raw$map[raw$Tree=="Eucalyptus regnans"]           <-  1208
raw$map[raw$Tree=="Sequoia sempervirens"]         <-  1226
raw$mat[raw$Tree=="Eucalyptus regnans"]           <-  11.6
raw$mat[raw$Tree=="Sequoia sempervirens"]         <-  12.6

```

Firstly, this type of code is *much* better than adding. Why

- Because you always want to maintain your raw datafile,
- You can see where the new value came from (it was addeded in a script)


```r
##' Modifies data by adding new values from table studyName/dataNew.csv
##'
##' Within the column given by 'newVariable', replace values that
##' match 'lookupValue' within column 'lookupVariable' with the value
##' newValue'.  If 'lookupVariable' is NA, then replace *all* elements
##' of 'newVariable' with the value 'newValue'.
##'
##' Note that lookupVariable can be the same as newVariable.
##'
##' @param data existing data.frame
##' @return modified data.frame
addNewData <- function(fileName, data) {
  import <- readNewData(studyName)
  if ( !is.null(import) ) {
    for (i in seq_len(nrow(import))) {
      col.to <- import$newVariable[i]
      col.from <- import$lookupVariable[i]
      if (is.na(col.from)) { # apply to whole column
        data[col.to] <- import$newValue[i]
      } else {
        ## apply to subset
        rows <- data[[col.from]] == import$lookupValue[i]
        data[rows,col.to] <- import$newValue[i]
      }
    }   
  }      
  data
}

##' Utility function to read/process dataNew.csv for addNewData
readNewData <- function(fileName) {

  if ( file.exists(filename) ) {
    import <- read.csv(filename, header=TRUE, stringsAsFactors=FALSE,
                       strip.white=TRUE)
    if ( nrow(import) > 0 ) {
      import$lookupVariable[import$lookupVariable == ""] <- NA
      nameIsOK <- import$newVariable %in% var.def$Variable
      if (any(!nameIsOK)) 
        stop("Incorrect name in var_out columns of dataMatchColumns.csv for ",
             studyName, "--> ", paste(import$newVariable[!nameIsOK],
                                      collapse=", "))
    } else {
      import <- NULL
    }
  } else {
    import <- NULL
  }
  import
}

```