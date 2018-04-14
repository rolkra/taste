################################################################################
## install packages (if required)
################################################################################

# install tidyverse
install.packages("tidyverse")

# install from github
if (!require(remotes)) install.packages("remotes")
remotes::install_github("rolkra/explore")

################################################################################
## read and explore data
################################################################################

# read data
data <- read.csv("https://raw.githubusercontent.com/rolkra/taste/master/beer_test_data_all.csv")
glimpse(data)

# use explore package to explore data
library(explore)
explore(data)
