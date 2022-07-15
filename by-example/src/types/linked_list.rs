#[derive(Debug)]
enum LinkedList<T> {
	Nil,
	Cons(T, Box<LinkedList<T>>),
}

impl LinkedList<i32> {
	fn new() -> LinkedList<i32> {
		Self::Nil
	}

	fn prepend(self, elem: i32) -> LinkedList<i32> {
		Self::Cons(elem, Box::new(self))
	}

	fn append(self, elem: i32) -> LinkedList<i32> {
		match self {
			Self::Nil => Self::Cons(elem, Box::new(Self::Nil)),
			Self::Cons(head, tail) => Self::Cons(head, Box::new(tail.append(elem))),
		}
	}

	fn nth(&self, n: usize) -> Option<&i32> {
		match *self {
			Self::Nil => None,
			Self::Cons(ref head, ref tail) => {
				if n == 0 {
					Some(head)
				} else {
					tail.nth(n - 1)
				}
			}
		}
	}

	fn len(&self) -> i32 {
		match *self {
			Self::Nil => 0,
			Self::Cons(_, ref tail) => 1 + tail.len(),
		}
	}

	fn stringify(&self) -> String {
		match *self {
			Self::Nil => String::new(),
			Self::Cons(ref head, ref tail) => {
				let tail = tail.stringify();

				if tail.is_empty() {
					format!("{}", head)
				} else {
					format!("{}, {}", head, tail)
				}
			}
		}
	}
}

fn main() {
	let list = LinkedList::new().prepend(1).append(2).append(3);

	println!("str {}", list.stringify());
	println!("nth 0 {}", list.nth(0).unwrap());
	println!("len {}", list.len());
}
