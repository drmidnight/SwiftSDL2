// struct Rect {
//     let size: Size
//     let position: Point
//     init(x: Int, y: Int, width: Int, height: Int) {
//         self.size = Size(width: width, height: height)
//         self.position = Point(x: x, y: y)
//     }
// }
import CSDL2
typealias Rect = SDL_Rect
extension Rect {
    static let zero: Rect = Rect(x: 0, y: 0, w: 0, h: 0)
}