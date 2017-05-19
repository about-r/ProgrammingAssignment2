### Test Script

# check env-t
ls()
source("cachematrix.R")

tst1 <- matrix(c(1,-1,1,2),2)

# allocate memory, create methods, set an initial matrix
mCM <- makeCacheMatrix( tst1 )

# validate
mCM
mCM$get()
mCM$getinv()

# solve 1st matrix, on 2nd call the result must be from cache 
cacheSolve( mCM )
cacheSolve( mCM )

# next matrix
tst2 <- matrix(c(1,-1,0,2),2)

# set to memory using set()-method
mCM$set( tst2 )

# validate
mCM$get()
mCM$getinv()

# solve 2nd matrix, on 2nd call the result must be from cache 
cacheSolve( mCM )
cacheSolve( mCM )

# validate the result is actually inverted
tst2 %*% cacheSolve( mCM )

# check env-t
ls()

### Test Result

> # check env-t
> ls()
character(0)
> source("cachematrix.R")
> 
> tst1 <- matrix(c(1,-1,1,2),2)
> 
> # allocate memory, create methods, set an initial matrix
> mCM <- makeCacheMatrix( tst1 )
> 
> # validate
> mCM
$set
function (x) 
{
    mtx <<- x
    inv <<- NULL
}
<environment: 0x000000000fdbc4e0>

$get
function () 
mtx
<environment: 0x000000000fdbc4e0>

$setinv
function (i) 
inv <<- i
<environment: 0x000000000fdbc4e0>

$getinv
function () 
inv
<environment: 0x000000000fdbc4e0>

> mCM$get()
     [,1] [,2]
[1,]    1    1
[2,]   -1    2
> mCM$getinv()
NULL
> 
> # solve 1st matrix, on 2nd call the result must be from cache 
> cacheSolve( mCM )
          [,1]       [,2]
[1,] 0.6666667 -0.3333333
[2,] 0.3333333  0.3333333
> cacheSolve( mCM )
from cache...
          [,1]       [,2]
[1,] 0.6666667 -0.3333333
[2,] 0.3333333  0.3333333
> 
> # next matrix
> tst2 <- matrix(c(1,-1,0,2),2)
> 
> # set to memory using set()-method
> mCM$set( tst2 )
> 
> # validate
> mCM$get()
     [,1] [,2]
[1,]    1    0
[2,]   -1    2
> mCM$getinv()
NULL
> 
> # solve 2nd matrix, on 2nd call the result must be from cache 
> cacheSolve( mCM )
     [,1] [,2]
[1,]  1.0  0.0
[2,]  0.5  0.5
> cacheSolve( mCM )
from cache...
     [,1] [,2]
[1,]  1.0  0.0
[2,]  0.5  0.5
> 
> # validate the result is actually inverted
> tst2 %*% cacheSolve( mCM )
from cache...
     [,1] [,2]
[1,]    1    0
[2,]    0    1
> 
> # check env-t
> ls()
[1] "cacheSolve"      "inv"             "makeCacheMatrix"
[5] "mCM"             "mtx"             "tst1"            "tst2"           
> 
