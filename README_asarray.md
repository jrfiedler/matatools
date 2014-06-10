matatools_asarray.mata
======================

functions
---------

- _real scalar_ **mt_isasarray**(*x*)
    
    - *x* - transmorphic scalar to test
    - returns 0 or 1

- _real scalar_ **mt_asarray_equal**(*A*, *B* [, *notfound*])
    
    - *A* - associative array
    - *B* - associative array
    - *notfound* - real scalar determining whether *A* and *B* must have the same *notfound* value
    - returns 0 or 1

- _void_ **mt_asarray_update**(*A*, *B* [, *replace*])
    
    - *A* - associative array
    - *B* - associative array
    - *replace* - real scalar determining whether *A*'s value should be replaced when a key already exists in *A*
	
- _transmorphic scalar_ **mt_asarray_build**(*keys*, *contents*, [, *notfound*])

    - *keys* - matrix with rows to used as keys
    - *contents* - matrix with rows to be used as contents
    - *notfound* - value to be set as associative arrays's *notfound* value 
    - returns associative array
	
- _string scalar_ **mt_asarray_keytype**(*A*)

    - *A* - associative array
    - returns `eltype` of *A*'s keys
	
- _real scalar_ **mt_asarray_keywidth**(*A*)

    - *A* - associative array
    - returns number of columns in *A*'s keys

examples
--------

    : keys = ("a" \ "b" \ "c" \ "d")
    
    : vals = (1 \ 2 \ 3 \ 4)
    
    : A = mt_asarray_build(keys, vals, 0)
    
    : mt_isasarray(A)
      1
    
    : B = asarray_create()
    
    : asarray(B, "d", 4)
    
    : asarray(B, "c", 3)
    
    : asarray(B, "b", 2)
    
    : asarray(B, "a", 1)
    
    : A == B
      0
    
    : mt_asarray_equal(A, B)
      1
    
    : asarray_notfound(B) == asarray_notfound(A)
      0
    
    : mt_asarray_equal(A, B, 1)
      0
