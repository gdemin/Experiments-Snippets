# Just want to compare performance: enableJIT vs uncompiled code.
# http://varianceexplained.org/r/boarding-pass-simulation/



simulate_seats <- function(seats = 100, planes = 100000) {
    m <- matrix(seq_len(seats), nrow = seats, ncol = planes)
    
    m[1, ] <- sample(seats, planes, replace = TRUE)
    m[cbind(m[1, ], seq_len(planes))] <- 1
    
    for (i in seq(2, seats - 1)) {
        taken <- which(m[i, ] != i)
        
        switch_with <- sample(seq(i, seats), length(taken), replace = TRUE)
        
        replacements <- m[cbind(switch_with, taken)]
        m[cbind(switch_with, taken)] <- m[i, taken]
        m[i, taken] <- replacements
    }
    m
}


set.seed(2015)

sim <- simulate_seats(seats = 100, planes = 100000)

# The probability of the final (100th) person sitting in the correct seat is:
    
mean(sim[100, ] == 100)

## [1] 0.49562

## non-vectorized

simulate_plane <- function(seats) {
    v <- seq_len(seats)
    
    # first person gets a random seat, switches with someone remaining
    v[1] <- sample(seats, 1)
    v[v[1]] <- 1
    
    for (i in seq(2, seats - 1)) {
        # if your seat isn't available, switch seats with someone remaining
        if (v[i] != i) {
            switch_with <- sample(seq(i, seats), 1)
            v[c(i, switch_with)] <- v[c(switch_with, i)]
        }
    }
    
    v
}

# benchmark

library(microbenchmark)
microbenchmark(simulate_seats(100, 1000),
               replicate(1000, simulate_plane(100)))

# Unit: milliseconds
# expr                                       min         lq       mean     median       uq  max        neval  cld
# simulate_seats(100, 1000)              4.995857   5.206263   5.512416   5.335628   5.6414 8.219942     100   a 
# replicate(1000, simulate_plane(100)) 119.861201 122.070035 125.585468 123.671814 125.4964 168.692893   100   b


# with compiler
library(compiler); enableJIT(3)

microbenchmark(simulate_seats(100, 1000),
               replicate(1000, simulate_plane(100)))


# two-fold speed up of non-vectorized solution

# Unit: milliseconds
# expr       min       lq     mean    median        uq
# simulate_seats(100, 1000)  4.698637  4.91332  5.42588  5.103839  5.342899
# replicate(1000, simulate_plane(100)) 60.271869 63.77671 65.95081 64.541355 66.481408
# max neval cld
# 19.14052   100  a 
# 117.85679   100   b

cmp_simulate = cmpfun(simulate_plane) 
microbenchmark(simulate_seats(100, 1000),
               replicate(1000, cmp_simulate(100)))

# no significant improvements

# Unit: milliseconds
# expr       min        lq      mean    median        uq
# simulate_seats(100, 1000)  4.706762  4.927431  5.402175  5.164138  5.519732
# replicate(1000, cmp_simulate(100)) 61.793890 64.132945 68.363543 65.690888 68.601931
# max neval cld
# 9.852297   100  a 
# 157.557633   100   b




