import CSDL2

public class Surface {
    internal var _surfacePtr: UnsafeMutablePointer<SDL_Surface>?

    public init(_ window: Window) {
        self._surfacePtr = SDL_GetWindowSurface(window._windowPtr)
    }

    public init(_ pointer: UnsafeMutablePointer<SDL_Surface>?) {
        self._surfacePtr = pointer
    }

    public init(from image: String) {
       self._surfacePtr = IMG_Load(image)
    }

    public init(size: Size, color: Color) {
        self._surfacePtr = SDL_CreateRGBSurface(0, Int32(size.width), Int32(size.height), 32, Uint32(color.r), Uint32(color.g), Uint32(color.b), Uint32(color.a))
    }

    deinit {
        print("Destroying Surface")
        self.free()
    }

    public func free() {
        SDL_FreeSurface(self._surfacePtr)
    }

    public func lock() {
        SDL_LockSurface(self._surfacePtr)
    }

    public func unlock() {
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

    var colorKey: Int {
        get {
            var key: UInt32 = 0
            SDL_GetColorKey(self._surfacePtr, &key)
            return Int(key)
        }
    }
    
    // TODO: fix this
   var pixelFormat: SDL_PixelFormat {
        get {
            return self._surfacePtr!.pointee.format.pointee
        }
    }
}

public extension Surface {
    func set(colorKey: Int, enabled: Bool = true) {
        SDL_SetColorKey(self._surfacePtr, enabled ? 1 : 0 , UInt32(colorKey))
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