matatools_capture.mata
======================

functions
---------

- **mt_capture**(*func*, *args_ptrs*, [*rv_ptr*])
    
    - *func* - pointer to function or string name
    - *arg_ptrs* - vector of pointers to *func*'s arguments; can be an empty matrix
    - *rv_ptr* - pointer to pre-defined variable to hold *func*'s return value; optional
	
- **mt_method_capture**(*instance*, *method*, *args_ptrs*, [*rv_ptr*])

    - *instance* - string name of class instance
    - *method* - string name of method
    - *arg_ptrs* - vector of pointers to the method's arguments; can be an empty matrix
    - *rv_ptr* - pointer to pre-defined variable to hold *func*'s return value; optional 

examples
--------

    : m = ("a", "string", "matrix")

    : min(m)
                 min():  3251  m[1,3] found where real or complex required
               <istmt>:     -  function returned error
    r(3251);

    : mt_capture("min", &m)
      3251

    : transmorphic add(a, b)
    > {
    > return(a + b)
    > }

    : rv = 0

    : mt_capture(&add(), (&100, &111), &rv)
      0

    : rv
      211