matatools_count.mata
======================

functions
---------

- _transmorphic scalar_ **mt_count**(*x*)
    
    - *x* - transmorphic matrix (any type except struct or class)
    - returns associative array of counts of elements

- _transmorphic scalar_ **mt_count_rows**(*x*)
    
    - *x* - transmorphic matrix (any type except struct or class)
    - returns associative array of counts of rows

- _transmorphic scalar_ **mt_count_cols**(*x*)
    
    - *x* - transmorphic matrix (any type except struct or class)
    - returns associative array of counts of columns

- _real scalar_ **mt_equal_counters**(*A*, *B*)
    
    - *A* - associative array (probably from one of the functions above)
    - *B* - associative array (probably from one of the functions above)
    - returns 0 or 1

- _real scalar_ **mt_equal_contents**(*x*, *y*, *samecount*)
    
    - *x* - transmorphic
    - *y* - transmorphic
    - *samecount* - real scalar, determines whether elements must appear same number of times
    - returns 0 or 1

- _real scalar_ **mt_equal_row_contents**(*x*, *y*, *samecount*)
    
    - *x* - transmorphic
    - *y* - transmorphic
    - *samecount* - real scalar, determines whether rows must appear same number of times
    - returns 0 or 1

- _real scalar_ **mt_equal_col_contents**(*x*, *y*, *samecount*)
    
    - *x* - transmorphic
    - *y* - transmorphic
    - *samecount* - real scalar, determines whether columns must appear same number of times
    - returns 0 or 1

examples
--------

    : keys = ("a" \ "b" \ "c" \ "d")
    
    : vals = (1 \ 2 \ 3 \ 4)
    
    : B = mt_asarray_build(keys, vals, 0)
    
    : x = ("d", "c", "b", "d", "c", "a", "d", "b", "c", "d")
    
    : A = mt_count(x)
    
    : mt_asarray_equal(A, B)
      1
    
    : x = (0, 1 \ 1, 0 \ 0, 1 \ 1, 1 \ 0, 1 \ 1, 0 \ 1, 1)
    
    : C = mt_count_rows(x)
    
    : asarray_keys(C)
           1   2
        +---------+
      1 |  1   0  |
      2 |  1   1  |
      3 |  0   1  |
        +---------+
    
    : asarray(C, (0, 1))
      3
    
    : asarray(C, (1, 0))
      2
    
    : asarray(C, (1, 1))
      2
    
    : asarray(C, (0, 0))
      0

    : D = mt_count_cols(x')
    
    : mt_asarray_equal(C, D)
      1
    
    : 
    : 
    : 
    : 
    : x = 1..15
    
    : y = (x[1..5] \ x[6..10] \ x[11..15])
    
    : mt_equal_contents(x, y)
      1
    
    : x = round(runiform(5, 5))
    
    : y = round(runiform(5, 5))
    
    : mt_equal_contents(x, y)
      0
    
    : mt_equal_contents(x, y, 0)
      1
    
    : mt_equal_row_contents(x, sort(x, 1))
      1


