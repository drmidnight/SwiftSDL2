import CSDL2

public struct Color {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8
    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    init(hex: Int, alpha: UInt8 = 255) {
        self.init(r:UInt8((hex >> 16)) & 0xff, g: UInt8((hex >> 08) & 0xff), b: UInt8((hex >> 00) & 0xff), a: alpha)
    }
}

extension Color {
    var sdlColor: SDL_Color {
        return SDL_Color(r: self.r, g: self.g, b: self.b, a: self.a)
    }

    // Needs PixelFormat struct. FIXME
    var mapRGB: UInt32 {
        var frmt = SDL_PixelFormat()
        return SDL_MapRGB(&frmt, self.r, self.g, self.b)
    }
}