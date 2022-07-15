fn main() {
	// you can add guards to match expressions
	match 1 {
		x if x < 2 => println!("less than 2"),
		x if x < 10 => println!("less than 10"),
		_ => println!("greater than 10"),
	}
}
