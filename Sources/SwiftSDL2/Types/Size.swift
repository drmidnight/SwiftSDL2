public struct Size {
    public let width: Int
    public let height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public init(width: Int32, height: Int32) {
        self.width = Int(width)
        self.height = Int(height)
    }
}

public extension Size {
    static var zero: Size {
        return Size(width: 0, height: 0)
    }
}
