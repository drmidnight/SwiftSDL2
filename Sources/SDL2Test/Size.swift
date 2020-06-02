struct Size {
    let width: Int
    let height: Int

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

     init(width: Int32, height: Int32) {
        self.width = Int(width)
        self.height = Int(height)
    }
}

extension Size {
    static var ZERO: Size {
        return Size(width: 0, height: 0)
    }
}
