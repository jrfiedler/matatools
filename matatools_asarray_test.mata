mata

class AsarrayTest extends testcase {
	void test_isasarray()
	void test_asarray_equal()
	void test_asarray_update()
	void test_asarray_build()
	void test_asarray_keytype()
	void test_asarray_keywidth()
}

void AsarrayTest::test_isasarray()
{
	this.assert(mt_isasarray(asarray_create()))
	this.assert(!mt_isasarray(0))
	this.assert(!mt_isasarray("a"))
}

void AsarrayTest::test_asarray_equal()
{
	transmorphic scalar A, B
	
	A = asarray_create()
	B = asarray_create()
	
	// check for error when inputs are not asarrays
	this.assert_error(3250, &mt_asarray_equal(), (&0, &B))
	this.assert_error(3250, &mt_asarray_equal(), (&A, &1))
	
	// simple case
	
	this.assert(mt_asarray_equal(A, B))
	
	asarray(A, "a", 1)
	asarray(A, "b", 2)
	asarray(A, "c", 3)
	asarray(A, "d", 4)
	
	asarray(B, "d", 4)
	asarray(B, "a", 1)
	asarray(B, "c", 3)
	asarray(B, "b", 2)
	
	this.assert(A != B)  // not equal as structs
	this.assert(mt_asarray_equal(A, B))
	
	asarray_notfound(A, 999)
	
	this.assert(mt_asarray_equal(A, B))
	this.assert(!mt_asarray_equal(A, B, 1))
	
	// multiple colums
	
	A = asarray_create("string", 2)
	B = asarray_create("string", 2)
	
	asarray(A, ("a", "a"), 1)
	asarray(A, ("b", "b"), 2)
	asarray(A, ("c", "c"), 3)
	asarray(A, ("d", "d"), 4)
	
	asarray(B, ("d", "d"), 4)
	asarray(B, ("a", "a"), 1)
	asarray(B, ("c", "c"), 3)
	asarray(B, ("b", "b"), 2)
	
	this.assert(mt_asarray_equal(A, B))
	
	asarray_notfound(A, 999)
	
	this.assert(mt_asarray_equal(A, B))
	this.assert(!mt_asarray_equal(A, B, 1))
	
	// unequal asarrays
	
	asarray(B, ("b", "b"), 12)
	this.assert(!mt_asarray_equal(A, B))
	
	asarray(B, ("b", "b"), 2)  // restore key:value
	asarray(A, ("e", "e"), 5)  // extend
	this.assert(!mt_asarray_equal(A, B))
	
	asarray(B, ("e", "e"), 5)  // extend
	asarray(B, ("f", "f"), 6)  // extend
	this.assert(!mt_asarray_equal(A, B))
	
	B = asarray_create()
	asarray(B, "a", 1)
	asarray(B, "b", 2)
	asarray(B, "c", 3)
	asarray(B, "d", 4)
	asarray(B, "e", 5)
	this.assert(!mt_asarray_equal(A, B))
	
	B = asarray_create("real", 2)
	asarray(B, (1, 1), 1)
	asarray(B, (2, 2), 2)
	asarray(B, (3, 3), 3)
	asarray(B, (4, 4), 4)
	asarray(B, (5, 5), 5)
	this.assert(!mt_asarray_equal(A, B))
}

void AsarrayTest::test_asarray_update()
{
	transmorphic scalar A, B, C
	
	A = asarray_create()
	B = asarray_create()
	
	// check for error when inputs are not asarrays
	this.assert_error(3250, &mt_asarray_update(), (&0, &B))
	this.assert_error(3250, &mt_asarray_update(), (&A, &1))
	
	// check for errors when inputs are incompatible
	B = asarray_create("real")
	this.assert_error(3250, &mt_asarray_update(), (&A, &B))
	this.assert_error(3250, &mt_asarray_update(), (&B, &A))
	
	B = asarray_create("string", 3)
	this.assert_error(3200, &mt_asarray_update(), (&A, &B))
	this.assert_error(3200, &mt_asarray_update(), (&B, &A))
	
	
	B = asarray_create()
	C = asarray_create()
	
	asarray(A, "a", 1)
	asarray(A, "b", 2)
	asarray(A, "c", 3)
	asarray(A, "d", 4)
	
	mt_asarray_update(C, A)
	this.assert(mt_asarray_equal(A, C))
	mt_asarray_update(C, B)
	this.assert(mt_asarray_equal(A, C))
	
	asarray(B, "c", 3.5)
	asarray(B, "d", 4.5)
	asarray(B, "e", 5.5)
	asarray(B, "f", 6.5)
	
	asarray(C, "e", 5.5)
	asarray(C, "f", 6.5)
	
	mt_asarray_update(A, B, 0)
	this.assert(mt_asarray_equal(A, C))
	
	asarray_remove(A, "e")
	asarray_remove(A, "f")
	asarray(C, "c", 3.5)
	asarray(C, "d", 4.5)
	
	mt_asarray_update(A, B, 1)
	this.assert(mt_asarray_equal(A, C))
	
	// multiple columns
	
	A = asarray_create("string", 2)
	B = asarray_create("string", 2)
	C = asarray_create("string", 2)
	
	asarray(A, ("a", "a"), 1)
	asarray(A, ("b", "b"), 2)
	asarray(A, ("c", "c"), 3)
	asarray(A, ("d", "d"), 4)
	
	mt_asarray_update(C, A)
	this.assert(mt_asarray_equal(A, C))
	mt_asarray_update(C, B)
	this.assert(mt_asarray_equal(A, C))
	
	asarray(B, ("c", "c"), 3.5)
	asarray(B, ("d", "d"), 4.5)
	asarray(B, ("e", "e"), 5.5)
	asarray(B, ("f", "f"), 6.5)
	
	asarray(C, ("e", "e"), 5.5)
	asarray(C, ("f", "f"), 6.5)
	
	mt_asarray_update(A, B, 0)
	this.assert(mt_asarray_equal(A, C))
	
	asarray_remove(A, ("e", "e"))
	asarray_remove(A, ("f", "f"))
	asarray(C, ("c", "c"), 3.5)
	asarray(C, ("d", "d"), 4.5)
	
	mt_asarray_update(A, B, 1)
	this.assert(mt_asarray_equal(A, C))
}

void AsarrayTest::test_asarray_build()
{
	transmorphic scalar A, B
	transmorphic keys, vals, notfound
	
	// check for errors
	keys = (
		asarray_create() \ 
		asarray_create() \ 
		asarray_create() \ 
		asarray_create()
	)
	vals = (1 \ 2 \ 3 \ 4)
	this.assert_error(3250, &mt_asarray_build(), (&keys, &vals))
	
	keys = ("a" \ "b" \ "c" \ "d")
	this.assert_error(3200, &mt_asarray_build(), (&keys, &(vals[2..4])))
	
	
	
	A = asarray_create()
	asarray(A, "d", 4)
	asarray(A, "c", 3)
	asarray(A, "b", 2)
	asarray(A, "a", 1)
	
	B = mt_asarray_build(keys, vals, "xxx")
	this.assert(mt_asarray_equal(A, B))
	this.assert(asarray_notfound(B) == "xxx")
	
	keys = (1 \ 2 \ 3 \ 4)
	vals = ("a" \ "b" \ "c" \ "d")
	
	A = asarray_create("real")
	asarray(A, 4, "d")
	asarray(A, 3, "c")
	asarray(A, 2, "b")
	asarray(A, 1, "a")
	
	B = mt_asarray_build(keys, vals, 999)
	this.assert(mt_asarray_equal(A, B))
	this.assert(asarray_notfound(B) == 999)
	
	// multiple columns
	
	keys = ("a", "a" \ "b", "b" \ "c", "c" \ "d", "d")
	vals = (1 \ 2 \ 3 \ 4)
	
	A = asarray_create("string", 2)
	asarray(A, ("d", "d"), 4)
	asarray(A, ("c", "c"), 3)
	asarray(A, ("b", "b"), 2)
	asarray(A, ("a", "a"), 1)
	
	B = mt_asarray_build(keys, vals, "xxx")
	this.assert(mt_asarray_equal(A, B))
	this.assert(asarray_notfound(B) == "xxx")
	
	keys = (1, 1 \ 2, 2 \ 3, 3 \ 4, 4)
	vals = ("a", "a" \ "b", "b" \ "c", "c" \ "d", "d")
	
	A = asarray_create("real", 2)
	asarray(A, (4, 4), ("d", "d"))
	asarray(A, (3, 3), ("c", "c"))
	asarray(A, (2, 2), ("b", "b"))
	asarray(A, (1, 1), ("a", "a"))
	
	B = mt_asarray_build(keys, vals, 999)
	this.assert(mt_asarray_equal(A, B))
	this.assert(asarray_notfound(B) == 999)
}

void AsarrayTest::test_asarray_keytype()
{
	transmorphic scalar A
	
	A = asarray_create()
	this.assert_equal(mt_asarray_keytype(A), "string")
	
	A = asarray_create("real")
	this.assert_equal(mt_asarray_keytype(A), "real")
	
	A = asarray_create("complex")
	this.assert_equal(mt_asarray_keytype(A), "complex")
	
	A = asarray_create("pointer")
	this.assert_equal(mt_asarray_keytype(A), "pointer")
}

void AsarrayTest::test_asarray_keywidth()
{
	transmorphic scalar A
	
	A = asarray_create("string", 1)
	this.assert_equal(mt_asarray_keywidth(A), 1)
	
	A = asarray_create("real", 5)
	this.assert_equal(mt_asarray_keywidth(A), 5)
	
	A = asarray_create("complex", 10)
	this.assert_equal(mt_asarray_keywidth(A), 10)
	
	A = asarray_create("pointer", 50)
	this.assert_equal(mt_asarray_keywidth(A), 50)
}

asarray_test = AsarrayTest()
asarray_test.name = "asarray_test"
asarray_test.test_names = (
	"test_isasarray",
	"test_asarray_equal",
	"test_asarray_update",
	"test_asarray_build",
	"test_asarray_keytype",
	"test_asarray_keywidth"
)
asarray_test.run()

mata drop asarray_test
mata drop AsarrayTest()

end
