/// x, y
struct Point(i32, i32);

struct Rectangle {
    top_left: Point,
    bottom_right: Point,
}

fn rect_area(rectangle: Rectangle) -> i32 {
    let Rectangle {
        top_left,
        bottom_right,
    } = rectangle;

    let Point(tl_x, tl_y) = top_left;
    let Point(br_x, br_y) = bottom_right;

    (br_x - tl_x) * (br_y - tl_y)
}

fn main() {
    let rect = Rectangle {
        top_left: Point(0, 0),
        bottom_right: Point(10, 10),
    };

    println!("{}", rect_area(rect));
}
