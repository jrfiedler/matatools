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


