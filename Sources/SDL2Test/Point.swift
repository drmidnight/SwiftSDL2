struct Point {
    let x: Int
    let y: Int
}

extension Point {
    static var zero: Point {
        return Point(x: 0, y: 0)
    }
}