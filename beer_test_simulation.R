# simulation of 1 double blinded test (1 out of 3)
n <- 1
sim <- rbinom(n = n, size = 1, p = 1/3)
sim
print(paste0("Beer test simulation: ", sum(sim), " of ", n, " are right, ", sum(sim)/n*100, "%"))

# simulation of n double blinded tests (1 out of 3)
n <- 25
sim <- rbinom(n = n, size = 1, p = 1/3)
sim
print(paste0("Beer test simulation: ", sum(sim), " of ", n, " are right, ", sum(sim)/n*100, "%"))

# simulation of m x n double blinded tests (1 out of 3)
m <- 10
n <- 25
sim <- rbinom(n = m, size = n, p = 1/3)
sim
hist(sim, col = "grey", main = "Simulation", xlim = c(0,17))
