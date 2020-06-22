import CSDL2

public class Surface {
    var _surfacePtr: UnsafeMutablePointer<SDL_Surface>?

    init(_ window: Window) {
        self._surfacePtr = SDL_GetWindowSurface(window._windowPtr)
    }

    init(_ pointer: UnsafeMutablePointer<SDL_Surface>?) {
        self._surfacePtr = pointer
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

    func lock() {
        SDL_LockSurface(self._surfacePtr)
    }

    func unlock() {
        SDL_UnlockSurface(self._surfacePtr)
    }
}

public extension Surface {
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

public extension Surface {

    func blitSurface(dstSurface: Surface, dstRect: Rect, srcRect: Rect) {
        var srcRect = srcRect
        var dstRect = dstRect
        SDL_UpperBlit(self._surfacePtr, &srcRect, dstSurface._surfacePtr, &dstRect)
    }

    func blitSurface(dstSurface: Surface, dstRect: Rect) {
        var dstRect = dstRect
        SDL_UpperBlit(self._surfacePtr, nil, dstSurface._surfacePtr, &dstRect)
    }

    func blitSurface(to surface: Surface) {
        SDL_UpperBlit(self._surfacePtr, nil, surface._surfacePtr, nil)
    }

    func fillRect(_ rect: Rect, color: Color) {
        var _sdlRect = rect
        SDL_FillRect(self._surfacePtr, &_sdlRect, color.mapRGB)
    }

    func fillRects(_ rects: [Rect], color: Color) {
        var fillRects: [SDL_Rect] = rects
        SDL_FillRects(self._surfacePtr, &fillRects, Int32(fillRects.endIndex), color.mapRGB)
    }
}