# Emphasise at the beginning

 - not going to learn how to program straight away
 - ask when things aren't clear
 - use the stickies
 - ask your neighbour first in the exercises
 
# Challenges (After morning tea)

Vocabulary challenges

 - R is a massive language: there are 2,376 functions included *by
   default* in version 2.15.1.  Each new version tends to get larger.
 - There are 4,396 packages.  Every package has several functions, and
   does different things.
 - You can never learn it all, but you will learn a good subset over
   time.
 - Don't stress about learning it all -- we'll try and cover a few
   strategies for knowing when to worry later.
   
Grammar challenges

 - Programming languages are (a bit) like spoken languages; there is a
   grammar to learn.
 - Think of ideas like filtering, repetition, aggregation, etc as the
   core concepts that the vocabulary maps on to.  While we'll cover
   very little of the vocabulary, we *will* cover most of the grammar
   you'll need.
   
Technical challenges

 - Lots of stuff to remember.

 - R studio will help ease the transition for the technical bits.

# Why learn R? (After lunch)

Presumably, as everyone is here voluntarily, they have some reason for
learning R.  Is it

- to do some basic statistics without paying for SAS/SPSS/etc?
  - to learn some programming?
  - to use nonstandard methods only available in R?
  - to write and use methods that don't exist elsewhere?

Many reasons for using R:

- Better than Excel
	- doesn't crash
    - history of what you did
	- larger range of analyses
	- *much* more powerful analyses
 - Better statistics
	- Most statistical research now based around R
	- Huge numbers of packages, for more or less any analysis you can
      think of.
 	- R interfaces to many tools (BUGS, JAGS, STAN)
	- Same interface (not one tool per analysis).
	- Output from one analysis can be used as input for the next
 - Reproducible research
	- Can treat your data as "fixed" and write scripts that do the
      analysis
	- Your whole thesis -- all figures and analysis -- could be run by
      single script.  *Know* where the figure came from.
	- The importance of this point is easy to miss until you
	  - have to convert an old figure to a current format for a job
        talk
	  - have to revise the paper held up at the journal for 6 months
        and you can't remember where a figure/table/result came from.
	  - update all the numbers in your paper because your data
        changed.
 - Employment opportunities
	- "data science" is currently very trendy - R users in demand
 - Better undertand models
    - R has powerful and easy to use plotting abilities -- plot the
      equations in the papers you read and get more understanding of
      the models
	- Easy to work with simple simulations.  Reimplement models to
      understand them, extend simulations for new papers.  Opens up
      whole new avenue of research.
	- Tools for working with many basic modelling tools
	  - linear algebra
	  - differential equations
	  - optimisation
	  - numerical integration
	- Can help you formalise your thoughts.  
	  - Easy to underestimate the level of precision that languages
		require.
 - Your advisor told you to.

But, everyone probably already has a reason.

# Approaches to programming (after afternoon tea)

My approach here in teaching this varies from learning most languages,
because the tools you need to build good programs and analyses in R
are quite different to other languages.  Loops / conditionals / etc
are the building blocks in most languages, but functions / indexing
are the building blocks in R.  The other is function repetition, which
we will cover now, or have just covered.
