fn main() {
	// everything is an expression.

	let a = match 1 {
		1 => "one",
		2 => "two",
		3 => "three",
		_ => "unknown",
	};
	let b = {
		let c = 3;
		c + 1
	};
	let d = if true { 1 } else { 2 };

	println!("{a}, {b}, {d}");
}
