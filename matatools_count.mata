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

end

