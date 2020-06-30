// struct Rect {
//     let size: Size
//     let position: Point
//     init(x: Int, y: Int, width: Int, height: Int) {
//         self.size = Size(width: width, height: height)
//         self.position = Point(x: x, y: y)
//     }
// }
import CSDL2
public typealias Rect = SDL_Rect
public extension Rect {
    init(x: Int, y: Int, w: Int, h: Int) {
        self.init(x: Int32(x), y: Int32(y), w: Int32(w), h: Int32(h))
    }
    static let zero: Rect = Rect(x: 0, y: 0, w: 0, h: 0)
}