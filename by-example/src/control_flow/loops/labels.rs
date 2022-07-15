#![allow(clippy::never_loop, unused_labels, unreachable_code)]

fn main() {
	// this label can be used to break _its_ loop instead of an inner loop
	'outer: loop {
		println!("Entered the outer loop");

		// this 'inner label isn't required, it's mostly semantic
		'inner: loop {
			println!("Entered the inner loop");

			// This would break only the inner loop
			// break;

			// This breaks the outer loop
			break 'outer;
		}

		println!("This point will never be reached");
	}
}
