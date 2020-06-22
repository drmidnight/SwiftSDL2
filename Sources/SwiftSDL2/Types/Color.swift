import CSDL2
public typealias Color = SDL_Color

public extension Color {
    init(hex: Int, alpha: UInt8 = 255) {
        self.init(r:UInt8((hex >> 16)) & 0xff, g: UInt8((hex >> 08) & 0xff), b: UInt8((hex >> 00) & 0xff), a: alpha)
    }

    init(r: Int, g: Int, b: Int ) {
        self.init(r: UInt8(r), g: UInt8(g), b: UInt8(b), a: 255)
    }
   
    // Needs PixelFormat struct. FIXME
    var mapRGB: UInt32 {
        var frmt = SDL_PixelFormat()
        return SDL_MapRGB(&frmt, self.r, self.g, self.b)
    }

    static let black: Color = SDL_Color(r: 0, g: 0, b: 0)
    static let gray: Color = SDL_Color(r: 120, g: 120, b: 120)
    static let white: Color = SDL_Color(r: 255, g: 255, b: 255)
    static let red: Color = SDL_Color(r: 255, g: 0, b: 0)
    static let blue: Color = SDL_Color(r: 0, g: 0, b: 255)
    static let green: Color = SDL_Color(r: 0, g: 255, b: 0)



}

