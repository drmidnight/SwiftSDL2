// struct Point {
//     let x: Int
//     let y: Int
// }
import CSDL2
typealias Point = SDL_Point

extension Point {
    static var zero: Point {
        return Point(x: 0, y: 0)
    }
}