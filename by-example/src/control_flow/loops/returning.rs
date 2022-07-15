#![allow(clippy::never_loop)]

fn main() {
	// you can return values from loops as well
	let a = loop {
		break 1;
	};

	println!("{}", a);
}
