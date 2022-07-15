fn main() {
	let a = 1;
	let b = 2;

	// if statements don't need (), they also can be assigned to variables (the tail
	// of the resulting branch is set)
	let _ = if a == b {
		println!("a == b");

		"abc"
	} else {
		println!("a != b");

		// if statements are expressions, so they need to return the same value on every
		// branch.
		"def"
	};
}
