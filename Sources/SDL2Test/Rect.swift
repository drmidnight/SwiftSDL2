struct Rect {
    let size: Size
    let position: Point
    init(x: Int, y: Int, width: Int, height: Int) {
        self.size = Size(width: width, height: height)
        self.position = Point(x: x, y: y)
    }
}

extension Rect {
    var x: Int {
        return self.position.x
    }

    var y: Int {
        return self.position.y
    }

    var width: Int {
        return self.size.width
    }

    var height: Int {
        return self.size.height
    }
}