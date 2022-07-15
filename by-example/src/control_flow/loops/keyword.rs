fn main() {
	// you can make an infinite loop (like `while (true) { ... }`) using `loop`
	let mut has_run = false;

	loop {
		println!("Hello, world!, {has_run}");

		// exit using `break`
		if has_run {
			break;
		}

		has_run = true
	}

	let mut i = 0;

	loop {
		i += 1;

		if i < 5 {
			// continue the loop and don't execute code after this point
			continue;
		} else if i < 10 {
			println!("i is less than 10, {i}");
		} else {
			break;
		}
	}
}
