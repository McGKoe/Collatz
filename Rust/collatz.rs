#![allow(dead_code)]


//use ::array_init::array_init;
//use self::itertools::Itertools;
use std::env;
use std::fmt;


#[derive(Clone, Copy, Debug)]
struct Cell {
    num: i32,
    length: i32,
}

impl Cell {
	fn new() -> Cell {
		Cell {num: 0, length: 0}
    }
}
impl fmt::Display for Cell {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // Customize so only `x` and `y` are denoted.
        write!(f, "{}		{}", self.num, self.length)
    }
}


fn collatz(n :i64) -> i64 {

	if n % 2 == 0 {
		return n/2;
	} 
	else {
		return n*3 + 1;
	}


}





fn main() {
	//take command line input
	let args: Vec<_> = env::args().collect();
    
	let arg1 = &args[1];

	let arg2 = &args[2];


	let arg1a: usize  = arg1.trim().parse::<usize>().unwrap();
	let arg2a: usize  = arg2.trim().parse::<usize>().unwrap();


	//convert arguments into usize constant to use as vector capacity
	let asize: usize  = arg2a as usize - arg1a as usize;




	let mut cells = Vec::<Cell>::with_capacity(asize);

	let mut begin = arg1a as i32;

	while begin < arg2a as i32 {

		//saving num
		let num = begin;
	
		//test value to calcualte collatz sequence length
		let mut test = begin as i64;
		let mut length = 0;

		while test > 1 {

			test = collatz(test);
			length = length + 1;


		}


		let temp = Cell {num, length};

		//add new Cell to list
		cells.push(temp);
	
		begin = begin + 1;


	}

	

	//sort list of cells by collatz sequence length
	cells.sort_by(|a, b| b.length.cmp(&a.length));
	cells.dedup_by(|a, b| a.length ==  b.length);


	//final vector
	let mut final1 = Vec::<Cell>::with_capacity(10);


	println!("Sorted by sequence length: ");
	for i in 0..10 {
		println!("{}", cells[i]);

		final1.push(cells[i]);
	}

	//sorts the longest collatz sequence numbers by the value
	final1.sort_by(|a, b| b.num.cmp(&a.num));

	println!("Sorted by integer size:  ");
	for i in 0..10 {
		println!("{}", final1[i]);
	}




}
