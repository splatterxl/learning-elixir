fn main() {
	match 3 {
		// return a single value
		2 => unreachable!(),
		// do lots of things
		3 => {
			println!("three");
			// do other stuff
		}
		// multiple cases? sure!
		4 | 5 => println!("four or five"),
		// hm, didn't catch it? fall back to this
		_ => println!("something else"),
	}

	let res: Result<i32, ()> = Ok(3);

	match res {
		// you can destructure
		Ok(a) => println!("ok {a}"),
		Err(_) => println!("err"),
	}
}
