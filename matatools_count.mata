mata

/**
* @brief Count the number of times each element appears in given matrix
* @param x matrix of string, real, complex or pointer
* @returns associative array of key=element : content=count
* @author James Fiedler
*/
transmorphic mt_count(transmorphic x)
{
	transmorphic val, counter
	real scalar i, j, xcols
	string scalar xtype
	
	xtype = eltype(x)
	
	if (xtype == "struct" | xtype == "class") {
		_error(3250, "structs and classes not allowed")
	}
	
	counter = asarray_create(xtype)
	asarray_notfound(counter, 0)
	
	xcols = cols(x)
	for (i = 1; i <= rows(x); i++) {
		for (j = 1; j <= xcols; j++) {
			val = x[i,j]
			asarray(counter, val, 1 + asarray(counter, val))
		}
	}
	
	return(counter)
}


/**
* @brief Count the number of times each row appears in given matrix
* @param x matrix of string, real, complex or pointer
* @returns associative array of key=row : content=count
* @author James Fiedler
*/
transmorphic mt_count_rows(transmorphic x)
{
	transmorphic row, counter
	string scalar xtype 
	real scalar i
	
	xtype = eltype(x)
	
	if (xtype == "struct" | xtype == "class") {
		_error(3250, "structs and classes not allowed")
	}
	
	counter = asarray_create(xtype, cols(x))
	asarray_notfound(counter, 0)
	
	for (i = 1; i <= rows(x); i++) {
		row = x[i,.]
		asarray(counter, row, 1 + asarray(counter, row))
	}
	
	return(counter)
}


/**
* @brief Count the number of times each column appears in given matrix
* @param x matrix of string, real, complex or pointer
* @returns associative array of key=column' : content=count
* @author James Fiedler
*/
transmorphic mt_count_cols(transmorphic x)
{
	transmorphic row, counter
	string scalar xtype 
	real scalar i
	
	xtype = eltype(x)
	
	if (xtype == "struct" | xtype == "class") {
		_error(3250, "structs and classes not allowed")
	}
	
	counter = asarray_create(xtype, rows(x))
	asarray_notfound(counter, 0)
	
	for (i = 1; i <= cols(x); i++) {
		row = (x[.,i])'
		asarray(counter, row, 1 + asarray(counter, row))
	}
	
	return(counter)
}


/**
* @brief See if two associative array counters have the same keys (and same counts if `samecount` = 1)
* @param a associative array counter
* @param b associative array counter
* @param samecount (optional) 0 or 1, whether elements must appear same number of times; default is 1
* @returns 0 or 1
* @author James Fiedler
*/
real scalar mt_equal_counters(
	transmorphic acounter, transmorphic bcounter, | real scalar samecount
)
{
	transmorphic loc, key
	
	if (args() == 2) {
		samecount = 1
	}
	
	if (mt_asarray_keytype(acounter) != mt_asarray_keytype(bcounter)) {
		return(0)
	}
	
	if (mt_asarray_keywidth(acounter) != mt_asarray_keywidth(bcounter)) {
		return(0)
	}
	
	if (asarray_elements(acounter) != asarray_elements(bcounter)) {
		return(0)
	}
	
	if (samecount) {
		loc = asarray_first(acounter)
		while (loc != NULL) {
			key = asarray_key(acounter, loc)
			if (asarray(acounter, key) != asarray(bcounter, key)) return(0)
			loc = asarray_next(acounter, loc)
		}
	}
	else {
		loc = asarray_first(acounter)
		while (loc != NULL) {
			key = asarray_key(acounter, loc)
			if (asarray(acounter, key) != 0 && asarray(bcounter, key) == 0) {
				return(0)
			}
			loc = asarray_next(acounter, loc)
		}
	}
	
	return(1)
}


/**
* @brief Check if two matrices (or scalars) have the same contents, regardless of arrangement
* @param a transmorphic
* @param b transmorphic
* @param samecount (optional) 0 or 1, whether elements must appear same number of times; default is 1
* @returns 0 or 1
* @author James Fiedler
*/
real scalar mt_equal_contents(
	transmorphic a, transmorphic b, | real scalar samecount
)
{
	if (args() == 2) {
		samecount = 1
	}
	
	if (eltype(a) != eltype(b)) return(0)
	
	if (samecount & rows(a) * cols(a) != rows(b) * cols(b)) return(0)
	
	return(mt_equal_counters(mt_count(a), mt_count(b), samecount))
}


/**
* @brief Check if two matrices (or scalars) have the same row contents, regardless of arrangement
* @param a transmorphic
* @param b transmorphic
* @param samecount (optional) 0 or 1, whether elements must appear same number of times; default is 1
* @returns 0 or 1
* @author James Fiedler
*/
real scalar mt_equal_row_contents(
	transmorphic a, transmorphic b, | real scalar samecount
)
{
	if (args() == 2) {
		samecount = 1
	}
	
	if (eltype(a) != eltype(b)) return(0)
	
	if (cols(a) != cols(b)) return(0)
	
	if (samecount & rows(a) != rows(b)) return(0)
	
	return(mt_equal_counters(mt_count_rows(a), mt_count_rows(b), samecount))
}


/**
* @brief Check if two matrices (or scalars) have the same column contents, regardless of arrangement
* @param a transmorphic
* @param b transmorphic
* @param samecount (optional) 0 or 1, whether elements must appear same number of times; default is 1
* @returns 0 or 1
* @author James Fiedler
*/
real scalar mt_equal_col_contents(
	transmorphic a, transmorphic b, | real scalar samecount
)
{
	if (args() == 2) {
		samecount = 1
	}
	
	if (eltype(a) != eltype(b)) return(0)
	
	if (rows(a) != rows(b)) return(0)
	
	if (samecount & cols(a) != cols(b)) return(0)
	
	return(mt_equal_counters(mt_count_cols(a), mt_count_cols(b), samecount))
}

end

