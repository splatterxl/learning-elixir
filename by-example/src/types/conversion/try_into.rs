use std::convert::TryFrom;

#[derive(Debug)]
struct A(bool);

impl TryFrom<String> for A {
	type Error = ();

	fn try_from(value: String) -> Result<Self, Self::Error> {
		if value == "a" {
			Ok(A(true))
		} else {
			Err(())
		}
	}
}

fn main() {
	let a = A::try_from("a".to_string()).unwrap();
	let b = A::try_from("b".to_string());

	println!("{a:?}, {b:?}");
}
