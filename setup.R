################################################################################
##  Triangle Test - Experiment Setup 
################################################################################

create_setup <- function()  {

# Product A and B, Select tree so that one is different
product_a <- "Puntigamer"
product_b <- "Gösser"
  
# Select Position X and Position Y
X <- sample(c(product_a, product_b),1)
Y <- sample(c(product_a, product_b),1)

# If different Products on Position X and Y, Z can be choosen randomly
if(X != Y) {
  Z <- sample(c(product_a, product_b),1)

# Position Z must be the one that is differnt  
} else if(X == product_a) {
    Z <- product_b
} else {
    Z <- product_a
}

setup <- c(X = X, Y = Y, Z = Z)
setup
}

# create setup
setup <- create_setup()
setup

