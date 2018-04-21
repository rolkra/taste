################################################################################
## install packages (if required)
################################################################################

# install from github
if (!require(remotes)) install.packages("remotes")
remotes::install_github("rolkra/explore")

################################################################################
## read and explore data
################################################################################

# read data
data <- read.csv("https://raw.githubusercontent.com/rolkra/taste/master/beer_test_data_all.csv")

# use explore package to explore data
library(explore)
explore(data)

################################################################################
## add fake result
################################################################################

# create a random result for double blinded test
data$double_blinded_fake <- rbinom(25, 1, 1/3)
explore(data)

