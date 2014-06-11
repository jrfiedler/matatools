mata

class CountTest extends testcase {
	void test_count()
	void test_count_rows()
	void test_count_cols()
	void test_equal_counters()
	void test_equal_contents()
	void test_equal_row_contents()
	void test_equal_col_contents()
}

void CountTest::test_count()
{
	transmorphic x, keys, B
	real colvector counts
	
	this.assert_error(
		3250,
		&mt_count(),
		&(asarray_create(), asarray_create() \ 
		  asarray_create(), asarray_create())
	)
	
	this.assert_error(3250, &mt_count(), &testcase(3,3))
	
	keys = (0 \ 1 \ 2 \ 3 \ 4 \ 5)
	counts = (1 \ 2 \ 3 \ 4 \ 5 \ 6)
	
	B = mt_asarray_build(keys, counts)
	
	x = (0, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4, 5, 5)
	this.assert(mt_asarray_equal(mt_count(x), B))
	
	x = (0, 1, 2 \ 3, 4, 5 \ 1, 2, 3 \ 4, 5, 2 \ 3, 4, 5 \ 3, 4, 5 \ 4, 5, 5)
	this.assert(mt_asarray_equal(mt_count(x), B))
	
	keys = ("0" \ "1" \ "2" \ "3" \ "4" \ "5")
	B = mt_asarray_build(keys, counts)
	x = (
		"0", "1", "2", "3", "4", "5", "1" \
		"2", "3", "4", "5", "2", "3", "4" \
		"5", "3", "4", "5", "4", "5", "5"
	)
	this.assert(mt_asarray_equal(mt_count(x), B))
}

void CountTest::test_count_rows()
{
	transmorphic x, keys, B
	real colvector counts
	
	this.assert_error(
		3250,
		&mt_count_rows(),
		&(asarray_create(), asarray_create() \ 
		  asarray_create(), asarray_create())
	)
	
	this.assert_error(3250, &mt_count_rows(), &testcase(3,3))
	
	keys = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0
	)
	counts = (1 \ 2 \ 3 \ 4 \ 5 \ 6)
	
	B = mt_asarray_build(keys, counts)
	
	x = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 1, 0
	)
	this.assert(mt_asarray_equal(mt_count_rows(x), B))
	
	keys = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0"
	)
	B = mt_asarray_build(keys, counts)
	x = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "1", "0"
	)
	this.assert(mt_asarray_equal(mt_count_rows(x), B))
}

void CountTest::test_count_cols()
{
	transmorphic x, keys, B
	real colvector counts
	
	this.assert_error(
		3250,
		&mt_count_cols(),
		&(asarray_create(), asarray_create() \ 
		  asarray_create(), asarray_create())
	)
	
	this.assert_error(3250, &mt_count_cols(), &testcase(3,3))
	
	
	keys = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0
	)
	counts = (1 \ 2 \ 3 \ 4 \ 5 \ 6)
	
	B = mt_asarray_build(keys, counts)
	
	x = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 1, 0
	)'
	this.assert(mt_asarray_equal(mt_count_cols(x), B))
	
	keys = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0"
	)
	B = mt_asarray_build(keys, counts)
	x = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "1", "0"
	)'
	this.assert(mt_asarray_equal(mt_count_cols(x), B))
}

void CountTest::test_equal_counters()
{
	transmorphic scalar A, B
	
	this.assert_error(., &mt_equal_counters(), (&0, &B))
	this.assert_error(., &mt_equal_counters(), (&A, &"B"))
	
	A = asarray_create()
	B = asarray_create()
	this.assert(mt_equal_counters(A, B))
	
	asarray(A, "a", 1)
	this.assert(!mt_equal_counters(A, B))
	
	asarray(A, "b", 4)
	asarray(B, "b", 4)
	asarray(B, "a", 3)
	this.assert(!mt_equal_counters(A, B))
	this.assert(mt_equal_counters(A, B, 0))
	
	A = asarray_create("complex", 3)
	B = asarray_create("complex", 3)
	
	asarray(A,  (1i, 0, 3 - 2i), 1)
	asarray(A, (1 + 1i, 0, -2i), 4)
	asarray(B, (1 + 1i, 0, -2i), 4)
	asarray(B,  (1i, 0, 3 - 2i), 3)
	this.assert(!mt_equal_counters(A, B))
	this.assert(mt_equal_counters(A, B, 0))
	
	asarray(A, (1i, 0, 3 - 2i), 3)
	this.assert(mt_equal_counters(A, B))
}

void CountTest::test_equal_contents()
{
	transmorphic x, y
	
	this.assert_error(
		3250,
		&mt_equal_contents(),
		(&(asarray_create(), asarray_create()),
		 &(asarray_create(), asarray_create()))
	)
	
	this.assert_error(3250, &mt_equal_contents(), (&testcase(2,2), &testcase(2,2)))
	
	x = (0, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4, 5, 5)
	y = (0, 1, 2 \ 3, 4, 5 \ 1, 2, 3 \ 4, 5, 2 \ 3, 4, 5 \ 3, 4, 5 \ 4, 5, 5)
	this.assert(mt_equal_contents(x, y))
	
	x = strofreal(y)
	y = (
		"0", "1", "2", "3", "4", "5", "1" \
		"2", "3", "4", "5", "2", "3", "4" \
		"5", "3", "4", "5", "4", "5", "5"
	)
	this.assert(mt_equal_contents(x, y))
	
	x = x[1..3,.]
	this.assert(mt_equal_contents(x, y, 0))
	this.assert(!mt_equal_contents(x, y))
}

void CountTest::test_equal_row_contents()
{
	transmorphic x, y
	
	this.assert_error(
		3250,
		&mt_equal_row_contents(),
		(&(asarray_create(), asarray_create()), 
		 &(asarray_create(), asarray_create()))
	)
	
	this.assert_error(3250, &mt_equal_row_contents(), (&testcase(2,2), &testcase(2,2)))
	
	
	x = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 1, 0
	)
	y = sort(x, 1)
	this.assert(mt_equal_row_contents(x, y))
	
	y = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0
	)
	this.assert(!mt_equal_row_contents(x, y))
	this.assert(mt_equal_row_contents(x, y, 0))
	
	
	x = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "1", "0"
	)
	y = sort(x, 1)
	this.assert(mt_equal_row_contents(x, y))
	
	y = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0"
	)
	this.assert(!mt_equal_row_contents(x, y))
	this.assert(mt_equal_row_contents(x, y, 0))
	
	y = sort(x, 1)'
	x = x'
	this.assert(!mt_equal_row_contents(x, y))
	this.assert(!mt_equal_row_contents(x, y, 0))
}

void CountTest::test_equal_col_contents()
{
	transmorphic x, y
	
	this.assert_error(
		3250,
		&mt_equal_col_contents(),
		(&(asarray_create(), asarray_create()), 
		 &(asarray_create(), asarray_create()))
	)
	
	this.assert_error(3250, &mt_equal_col_contents(), (&testcase(2,2), &testcase(2,2)))
	
	
	x = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 0, 1 \
		1, 1, 0 \
		1, 1, 0
	)'
	y = sort(x', 1)'
	this.assert(mt_equal_col_contents(x, y))
	y = (
		0, 0, 1 \
		0, 1, 0 \
		0, 1, 1 \
		1, 0, 0 \
		1, 0, 1 \
		1, 1, 0
	)'
	this.assert(!mt_equal_col_contents(x, y))
	this.assert(mt_equal_col_contents(x, y, 0))
	
	x = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "0", "1" \
		"1", "1", "0" \
		"1", "1", "0"
	)'
	y = sort(x', 1)'
	this.assert(mt_equal_col_contents(x, y))
	y = (
		"0", "0", "1" \
		"0", "1", "0" \
		"0", "1", "1" \
		"1", "0", "0" \
		"1", "0", "1" \
		"1", "1", "0"
	)'
	this.assert(!mt_equal_col_contents(x, y))
	this.assert(mt_equal_col_contents(x, y, 0))
	
	y = sort(x', 1)
	x = x'
	this.assert(!mt_equal_col_contents(x, y))
	this.assert(!mt_equal_col_contents(x, y, 0))
}

count_test = CountTest()
count_test.name = "count_test"
count_test.test_names = (
	"test_count",
	"test_count_rows",
	"test_count_cols",
	"test_equal_counters",
	"test_equal_contents",
	"test_equal_row_contents",
	"test_equal_col_contents"
)
count_test.run()

mata drop count_test
mata drop CountTest()

end
