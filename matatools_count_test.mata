mata

class CountTest extends testcase {
	void test_count()
	void test_count_rows()
	void test_count_cols()
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

count_test = CountTest()
count_test.name = "count_test"
count_test.test_names = (
	"test_count",
	"test_count_rows",
	"test_count_cols"
)
count_test.run()

mata drop count_test
mata drop CountTest()

end
