rm( list  = ls() )
source( "correlationCalcs2.R")
require( ape )
require( mvtnorm )
require( caper )


# ------- Part 1 - demonstration of calculations of likelihoods for single traits ------ 

n <- 1000
phy <- rcoal(n)
V <- vcv.phylo( phy )
x <- matrix( rmvnorm( 1, sigma = V), ncol  =1)
rownames(x) <- rownames(V)

# ----- Calculate likelihood for a single trait -----
# ----- Both give the same result, but using different algorithms
likGeneral( x, vcv.phylo( phy) , 0, 1 )
clikGeneral( x, phy, 0, 1)


# ------ ML for a single trait ---------
# ---- Now estimate maximum likelihood parameters
likLambda( x, vcv.phylo(phy) , 1)
clikLambda(x, phy, 1) 

# ----Here are some timings: 
# --- first, including the formation of V
system.time( likLambda( x, vcv.phylo(phy) , 1) )
system.time( clikLambda(x, phy, 1) )

# --- Now excluding calculation of V
V <- vcv.phylo(phy)
system.time( likLambda( x, V , 1) )
system.time( clikLambda(x, phy, 1) )




# ------- Part 2 - demonstration of calculations of likelihoods for pairs of traits ------ 

W <- matrix(c(1,0.0,0.0,1),ncol  =2) 		# This is the trait covariance matrix
V <- vcv.phylo(phy)	
sigma <- W %x% V

x <- rmvnorm(1, mean = c(rep(0, n), rep(20, n) ), sigma = sigma)
x <- matrix(x, ncol = 2, byrow = FALSE) 
rownames(x) <- rownames(V)

# ---- Examples of likelihoods for a pair of traits and given mean & variances:

mu <- c(0,0)
sigmaMat <-  matrix( c(1,0,0,1), ncol  =2) 
likGeneral( x, vcv.phylo(phy), mu, sigmaMat )
clikGeneral( x, phy, mu, sigmaMat )


# ---- Estimates a common lambda for the two traits
# ---- Assume that V is already formed
maxLikLambda(x, V )
maxClikLambda(x, phy)



# ---- And now separate lambdas for the two
maxLikMultilambdas( x, V)
maxClikMultilambdas(x, phy)






# ------- Part 3 - demonstration of some PGLS models -------

# generate dummy data (lambda  = 0)
dat <- matrix( rnorm(n *2), ncol = 2 )
dat <- data.frame(x = dat[,1], y = dat[,2], names = phy$tip, row.names = phy$tip)
cdat <-  data.frame(x = dat[,1], y = dat[,2], row.names = phy$tip)
comp.dat <- comparative.data( phy, dat, names)

# Here is an example of the method
model <- cpglm(  y ~ -1,  cdat, phy )


# And here it is but using slow matrix inversion
slowModel <- pgls( y ~ 1, data = comp.dat)


# Correlation - lm 
model <- cpglm( y ~ x - 1, cdat, phy )
summary(model)
slowModel <- pgls( y ~ x, comp.dat )
summary(slowModel)







# ------- Finally, showing off.....

n <- 1E+6
phy <- rtree(n)
x <- matrix( rnorm(n), ncol = 1)
rownames(x) <- phy$tip

# Might take a day to run......
maxClikLambda(x, phy)

# ......but couldn't even attempt this the other way, i.e. don't run:

# macLikLambda( x, vcv.phylo( phy ) )

