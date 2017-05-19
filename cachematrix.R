## This module consists of two functions
##
## makeCacheMatrix
##  The function to create a container to store two matrix objects:
##   a) mtx - the source matrix
##   b) inv - the object to cache the inverse of mtx.
##  This function also provides get/set access methods to manage stored objects.
##
##  cacheSolve:
##   This function computes the inverse of the matrix 'mtx' stored by 
##   makeCacheMatrix above. If the inverse has already been calculated
##  ('inv' is not reset/NULL), then cacheSolve retrieves the inverse
##   from the cache rather than calculate it again.
##

makeCacheMatrix <- function(x=matrix()) {
        ## 1/ container for: 'mtx'-a source matrix, 'inv'-the inverse of 'mtx'
        ## 2/ initialize both: mtx, inv
        ## 3/ return list of methods to access 'mtx', 'inv'
        set <- function(x) {
                mtx <<- x
                inv <<- NULL
        }
        setinv <- function(i)inv <<- i
        getinv <- function() inv
        get    <- function() mtx
        set(x)
	      list( set = set,
              get = get,
              setinv = setinv,
              getinv = getinv )
}

cacheSolve <- function(x, ...) {
        ## 1/ verify if the inverse was reset
        ## 2/ if need be - calculate, store the new inverse 
        ## 3/ return the inverse matrix (from cache or calculated)
        inv <- x$getinv()
        if( !is.null(inv) ) { 
        ## 'not reset' - the copy from container
                message("from cache...")
        }
	      else { 
        ## 'reset' - get the new source, calculate and store new inverted
                a <- x$get()
                inv <- solve(a)
                x$setinv(inv)
	      }
        inv
}