import CSDL2

class Surface {
    var _surfacePtr: UnsafeMutablePointer<SDL_Surface>?

    init(_ window: Window) {
        self._surfacePtr = SDL_GetWindowSurface(window._windowPtr)
    }

    init(from image: String) {
       self._surfacePtr = IMG_Load(image)
    }

    deinit {
        print("Destroying Surface")
        self.free()
    }

    func free() {
        SDL_FreeSurface(self._surfacePtr)
    }
}

extension Surface {
    var clipRect: Rect {
        get {
            var rect = Rect()
            SDL_GetClipRect(self._surfacePtr, &rect)
            return rect
        }
        set {
            var rect = newValue
            SDL_SetClipRect(self._surfacePtr, &rect)
        }
    }

    var alphaMod: Int {
        get {
            var alphaPtr:Uint8 = 0
            SDL_GetSurfaceAlphaMod(self._surfacePtr, &alphaPtr)
            return Int(alphaPtr)
        } 
        set {
            SDL_SetSurfaceAlphaMod(self._surfacePtr, UInt8(newValue))
        }
    }

    var blendMode: BlendMode {
        get {
            var blendMode: SDL_BlendMode = SDL_BLENDMODE_NONE
            SDL_GetSurfaceBlendMode(self._surfacePtr, &blendMode)
            return BlendMode(rawValue: blendMode.rawValue) ?? .none
        }
        set {
            SDL_SetSurfaceBlendMode(self._surfacePtr, newValue.toSDL)
        }
    }

    var colorMod: Color {
        get {
            var r: Uint8 = 0
            var g: Uint8 = 0
            var b: Uint8 = 0
            SDL_GetSurfaceColorMod(self._surfacePtr, &r, &g, &b)
            return Color(r: r, g: g, b: b, a: 255)
        }
        set {
            SDL_SetSurfaceColorMod(self._surfacePtr, newValue.r, newValue.g, newValue.b)
        }
    }
}

extension Surface {
    func fillRect(_ rect: Rect, color: Color) {
        var _sdlRect = rect
        SDL_FillRect(self._surfacePtr, &_sdlRect, color.mapRGB)
    }

    func fillRects(_ rects: [Rect], color: Color) {
        var fillRects: [SDL_Rect] = rects
        SDL_FillRects(self._surfacePtr, &fillRects, Int32(fillRects.endIndex), color.mapRGB)
    }
}