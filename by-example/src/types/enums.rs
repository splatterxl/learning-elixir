#![allow(dead_code)]

enum Colors {
	Red = 0xff0000,
	// Green = 0x00ff00,
	Blue = 0x0000ff,
}

fn main() {
	// Print the Red color as a hexidecimal string
	println!("Roses are #{:06x}", Colors::Red as i32);
	println!("Violets are #{:06x}", Colors::Blue as i32);
	println!("Rust is so fast");
	println!("I can tell you!");

	println!();

	// you can also use iota enums
	#[repr(i32)]
	#[derive(Debug)]
	enum MessageType {
		Hello,
		Goodbye,
	}

	let msg = MessageType::Hello;
	let msg_i32 = MessageType::Hello as i32;

	println!("{:?} = {}!", msg, msg_i32);
}
