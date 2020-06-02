import CSDL2

public struct Color {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8
}

extension Color {
    var sdlColor: SDL_Color {
        return SDL_Color(r: self.r, g: self.g, b: self.b, a: self.a)
    }
}