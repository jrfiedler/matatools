capture mata: mata drop noisy_inst
capture mata: mata drop noisy_class()
capture mata: mata drop noisy_sqrt()
capture mata: mata drop test_inst
capture mata: mata drop cap_test()

mata
	arg_ptrs = (&1, &1e-15)
	
	class noisy_class {
		numeric noisy_sqrt()
	}
	
	numeric noisy_class::noisy_sqrt(numeric a, | real scalar noise)
	{
		real scalar nrows, ncols
		numeric matrix noise_mat
		
		if (args() == 1) {
			noise = 1e-5
		}
		
		nrows = rows(a)
		ncols = cols(a)
		noise_mat = rnormal(nrows, ncols, 0, noise) 
		if (eltype(a) == "complex") {
			noise_mat = noise_mat :+ (rnormal(nrows, ncols, 0, noise) * 1i)
		}
		
		return(sqrt(a) :+ noise_mat)
	}
	
	// mt_method_capture() can't be used with classes defined within function
	noisy_inst = noisy_class()

	numeric noisy_sqrt(numeric a, | real scalar noise)
	{
		real scalar nrows, ncols
		numeric matrix noise_mat
		
		if (args() == 1) {
			noise = 1e-5
		}
		
		nrows = rows(a)
		ncols = cols(a)
		noise_mat = rnormal(nrows, ncols, 0, noise) 
		if (eltype(a) == "complex") {
			noise_mat = noise_mat :+ (rnormal(nrows, ncols, 0, noise) * 1i)
		}
		
		return(sqrt(a) :+ noise_mat)
	}
	
	class cap_test extends testcase {
		void test_mt_capture()
		void test_mt_method_capture()
	}
	
	void cap_test::test_mt_capture()
	{
		external pointer(numeric scalar) vector arg_ptrs
		pointer(numeric scalar) scalar rv
		numeric scalar bad_type, rc
		
		rv = &0
		bad_type = 0
	
		// test func arg errors
		this.assert_error(
			3257, &mt_capture(), (&(bad_type), &(&1), &(&rv))
		)
		
		// 3rd arg not scalar
		this.assert_error(
			3204,
			&mt_capture(),
			(&(&mt_capture(), &noisy_sqrt()), &(&1), &(&rv))
		)
						  
		// test return value ptr errors
		this.assert_error(
			3257, &mt_capture(), (&(&noisy_sqrt()), &(&1), &bad_type)
		)
		this.assert_error(
			3204,
			&mt_capture(),
			(&(&noisy_sqrt()), &(&1), &(&bad_type, &bad_type))
		)
						  
		// test arg_ptrs errors
		this.assert_error(
			3257, &mt_capture(), (&(&noisy_sqrt()), &(1, 2, 3, 4), &(&rv))
		)
		this.assert_error(
			3200, &mt_capture(), (&(&noisy_sqrt()), &(&1, &2 \ &3, &4), &(&rv))
		)
		
		// captured errors, with function pointer
		this.assert_equal(3001, mt_capture(&noisy_sqrt(), J(0,0,NULL)))
		this.assert_equal(
			3001,
			mt_capture(&noisy_sqrt(), (&1, &1e-10, &999), &rv)
		)
		this.assert_equal(3251, mt_capture(&noisy_sqrt(), (&"blah")))
		
		// captured errors, with function name
		this.assert_equal(3001, mt_capture(&noisy_sqrt(), J(0,0,NULL)))
		this.assert_equal(
			3001,
			mt_capture("noisy_sqrt", (&1, &1e-10, &999), &rv)
		)
		this.assert_equal(3251, mt_capture("noisy_sqrt", (&"blah")))
		this.assert_equal(3499, mt_capture("no_such_func", J(0,0,NULL)))
		
		// mt_capture() with no errors, with function pointer
		rc = mt_capture(&noisy_sqrt(), arg_ptrs, &rv)
		this.assert_equal(rc, 0)
		this.assert_close(rv, 1)
		
		// mt_capture() with no errors, with function name
		rc = mt_capture("noisy_sqrt", arg_ptrs, &rv)
		this.assert_equal(rc, 0)
		this.assert_close(rv, 1)
	}
	
	void cap_test::test_mt_method_capture()
	{
		external class noisy_class scalar noisy_inst
		external pointer(numeric scalar) vector arg_ptrs
		pointer(numeric scalar) scalar rv
		numeric scalar not_ptr, rc
		
		rv = &0
		not_ptr = 0
		
		// test class_name arg errors
		this.assert_error(
			3250,
			&mt_method_capture(),
			(&(&noisy_sqrt()), &"noisy_sqrt", &(&1), &(&rv))
		)
		this.assert_error(
			3204,
			&mt_method_capture(), 
		    (&("noisy_inst", "noisy_inst"), &"noisy_sqrt", &(&1), &(&rv))
		)  // 3rd arg not scalar
	
		// test func_name arg errors
		this.assert_error(
			3250,
			&mt_method_capture(),
			(&"noisy_inst", &(&noisy_sqrt()), &(&1), &(&rv))
		)
		this.assert_error(
			3204,
			&mt_method_capture(), 
		    (&"noisy_inst", &("noisy_sqrt", "noisy_sqrt"), &(&1), &(&rv))
		)  // 4th arg not scalar
						  
		// test return value ptr errors
		this.assert_error(
			3257,
			&mt_method_capture(), 
		    (&"noisy_inst", &(&noisy_sqrt()), &(&1), &not_ptr)
		)
		this.assert_error(
			3204,
			&mt_method_capture(),
		    (&"noisy_inst", &"noisy_sqrt", &(&1), &(&not_ptr, &not_ptr))
		)
						  
		// test arg_ptr errors
		this.assert_error(
			3257,
			&mt_method_capture(),
			(&"noisy_inst", &"noisy_sqrt", &(1, 2, 3, 4), &(&rv))
		)
		this.assert_error(
			3200,
			&mt_method_capture(),
		    (&"noisy_inst", &"noisy_sqrt", &(&1, &2 \ &3, &4), &(&rv))
		)
						 
		// no such class instance error
		this.assert_equal(
			3000, mt_method_capture("perfect_inst", "noisy_sqrt", J(0,0,NULL))
		)
						 
		// no such function error
		this.assert_equal(
			3000, mt_method_capture("noisy_inst", "perfect_sqrt", J(0,0,NULL))
		)
			
		// captured errors
		this.assert_equal(
			3001, mt_method_capture("noisy_inst", "noisy_sqrt", J(0,0,NULL))
		)
		this.assert_equal(
			3001,
			mt_method_capture(
				"noisy_inst",
				"noisy_sqrt",
				(&1, &1e-10, &999),
				&rv
			)
		)
		this.assert_equal(
			3251, mt_method_capture("noisy_inst", "noisy_sqrt", (&"blah"))
		)
		
		// mt_method_capture() with no errors
		rc = mt_method_capture("noisy_inst", "noisy_sqrt", arg_ptrs, &rv)
		this.assert_equal(rc, 0)
		this.assert_close(rv, 1)
	}
	
	test_inst = cap_test()
	test_inst.name = "test_inst"
	test_inst.test_names = ("test_mt_capture", "test_mt_method_capture")
	test_inst.run()
	
	// Now check that arg_ptrs, noisy_sqrt(), etc., can be dropped.
	mata drop arg_ptrs
	mata drop noisy_sqrt()
	mata drop noisy_inst
	mata drop noisy_class()
	
	mata drop test_inst
	mata drop cap_test()
end
