mata

/**
* @brief Update an asarray (in place) to include key:contents pairs from another asarray
* @param A associative array
* @param B associative array
* @param replace (optional) real scalar, determines if values in A should be overwritten, default is 1
* @author James Fiedler
*/
void mt_asarray_update(
	transmorphic scalar A, transmorphic scalar B, | real scalar replace
)
{
	transmorphic scalar locA, locB, key
	
	// check that A is an asarray and get loc of first key
	if (mt_capture("asarray_first", &A, &locA)) {
		_error(3250, "1st input is not an associative array")
	}
	
	// check that B is an asarray and get loc of first key
	if (mt_capture("asarray_first", &B, &locB)) {
		_error(3250, "2nd input is not an associative array")
	}

	if (eltype(asarray_key(A, locA)) != eltype(asarray_key(B, locB))) {
		_error(3250, "input keys are not same type")
	}
	
	if (cols(asarray_key(A, locA)) != cols(asarray_key(B, locB))) {
		_error(3200, "input keys do not have same dimensions")
	}
	
	if (args() == 2) {
		replace = 1
	}
	
	if (!replace) {
		for (; locB != NULL; locB = asarray_next(B, locB)) {
			key = asarray_key(B, locB)
			if (!asarray_contains(A, key)) {
				asarray(A, key, asarray(B, key))
			}
		}
	}
	else {
		for (; locB != NULL; locB = asarray_next(B, locB)) {
			key = asarray_key(B, locB)
			asarray(A, key, asarray(B, key))
		}
	}
}


/**
* @brief Test whether input is an associative array
* @param x element to test
* @returns 0 or 1
* @author James Fiedler
*/
real scalar mt_isasarray(transmorphic scalar x)
{
	return(!(mt_capture("asarray_first", &x)))
}


/**
* @brief Build associative array from matrix of keys and matrix of contents, row-by-row
* @param keys transmorphic (not struct or class)
* @param contents transmorphic
* @param notfound (optional) transmorphic, must match keys in eltype and number of columns
* @returns associative array
* @author James Fiedler
*/
transmorphic scalar mt_asarray_build(
	transmorphic keys, transmorphic contents, | transmorphic vector notfound
)
{
	transmorphic scalar A
	string scalar keytype
	real scalar i, nkeys
	
	keytype = eltype(keys)

	if (keytype == "struct" | keytype == "class") {
		_error(3250, "struct and class not allowed as key types")
	}
	
	nkeys = rows(keys)
	
	if (nkeys != rows(contents)) {
		_error(3200, "keys and contents have different number of rows")
	}
	
	A = asarray_create(keytype, cols(keys))
	
	if (args() == 3) {
		asarray_notfound(A, notfound)
	}

	for (i = 1; i <= nkeys; i++) {
		asarray(A, keys[i,.], contents[i,.])
	}
	
	return(A)
}


/**
* @brief Check whether two associative arrays have the same key:contents pairs
* @param A associative array
* @param B associative array
* @param notfound real scalar, whether A and B must have equal notfound values, default value is 0
* returns 0 or 1
* @author James Fiedler
*/
real scalar mt_asarray_equal(
	transmorphic scalar A, transmorphic scalar B, | real scalar notfound
)
{
	transmorphic scalar locA, locB, key
	
	// check that A is an asarray and get loc of first key
	if (mt_capture("asarray_first", &A, &locA)) {
		_error(3250, "1st input is not an associative array")
	}
	
	// check that B is an asarray and get loc of first key
	if (mt_capture("asarray_first", &B, &locB)) {
		_error(3250, "2nd input is not an associative array")
	}

	if (asarray_elements(A) != asarray_elements(B)) {
		return(0)
	}
	
	if (eltype(asarray_key(A, locA)) != eltype(asarray_key(B, locB))) {
		return(0)
	}
	
	if (cols(asarray_key(A, locA)) != cols(asarray_key(B, locB))) {
		return(0)
	}
	
	for (; locB != NULL; locB = asarray_next(B, locB)) {
		key = asarray_key(B, locB)
		if (asarray(A, key) != asarray(B, key)) {
			return(0)
		}
	}
	
	if (args() == 3 & notfound) {
		return(asarray_notfound(A) == asarray_notfound(B))
	}
	
	return(1)
}

end
