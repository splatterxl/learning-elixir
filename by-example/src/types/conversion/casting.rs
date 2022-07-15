fn main() {
	let a: u8 = 0x41;
	let b = a as i16;

	// u8 can be cast as char, i8 cannot
	let latin_capital_letter_a = a as char;

	println!("{a} -> {b} -> {latin_capital_letter_a}");
}
