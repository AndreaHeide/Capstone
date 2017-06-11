## Function for parallel processing to save some time (Source: RPubs, Eric Rodriguez, 2016)

parallelizeTask <- function(task, ...) {
        # Calculate the number of cores
        ncores <- detectCores() - 1
        # Initiate cluster
        cl <- makeCluster(ncores)
        registerDoParallel(cl)
        r <- task(...)
        stopCluster(cl)
        r
}
