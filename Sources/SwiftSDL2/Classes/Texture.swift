import CSDL2
import Foundation

enum TextureAccess: Int32 {
    case `static`  /** SDL_TEXTUREACCESS_STATIC < Changes rarely, not lockable */
    case streaming /** SDL_TEXTUREACCESS_STREAMING < Changes frequently, lockable */
    case target    /** SDL_TEXTUREACCESS_TARGET < Texture can be used as a render target */
}

class Texture {
    var _texturePtr: OpaquePointer?
    var _pixelsPtr: UnsafeMutablePointer<UnsafeMutableRawPointer?>?
    var _pitchPtr: UnsafeMutablePointer<Int32>?

    init(renderer: Renderer, format: Uint32, access: TextureAccess, size: Size) {
        self._texturePtr = SDL_CreateTexture(renderer._rendererPtr, format, access.rawValue, Int32(size.width), Int32(size.height))
    }

    init(pointer: OpaquePointer?) {
        self._texturePtr = pointer
    }

    init(renderer: Renderer, image: String) {
        let surfacePtr: UnsafeMutablePointer<SDL_Surface>? = IMG_Load(image)
        defer{SDL_FreeSurface(surfacePtr)}
        self._texturePtr = Texture.createFromSurface(renderer: renderer, surface: surfacePtr)
    }

    init(renderer: Renderer, surface: Surface) {
        self._texturePtr = Texture.createFromSurface(renderer: renderer, surface: surface._surfacePtr)
    }

    deinit {
        self.destroy()
    }

    func destroy() {
        print("Destroying Texture")
        SDL_DestroyTexture(self._texturePtr)
        self._texturePtr = nil
        self._pixelsPtr = nil
        self._pitchPtr = nil
    }
}

extension Texture {
    var alphaMod: Int {
        get {
            var alphaPtr:Uint8 = 0
            SDL_GetTextureAlphaMod(self._texturePtr, &alphaPtr)
            return Int(alphaPtr)
        } 
        set {
            SDL_SetTextureAlphaMod(self._texturePtr, UInt8(newValue))
        }
    }

    var blendMode: BlendMode {
        get {
            var blendMode: SDL_BlendMode = SDL_BLENDMODE_NONE
            SDL_GetTextureBlendMode(self._texturePtr, &blendMode)
            return BlendMode(rawValue: blendMode.rawValue) ?? .none
        }
        set {
            SDL_SetTextureBlendMode(self._texturePtr, newValue.toSDL)
        }
    }

    var colorMod: Color {
        get {
            var r: Uint8 = 0
            var g: Uint8 = 0
            var b: Uint8 = 0
            SDL_GetTextureColorMod(self._texturePtr, &r, &g, &b)
            return Color(r: r, g: g, b: b, a: 255)
        }
        set {
            SDL_SetTextureColorMod(self._texturePtr, newValue.r, newValue.g, newValue.b)
        }
    }

    //convinence
    var info: TextureInfo {
        return self.query()
    }
}


extension Texture {
      // wrap Surface next
    static func createFromSurface(renderer: Renderer, surface:  UnsafeMutablePointer<SDL_Surface>?) -> OpaquePointer? {
        return SDL_CreateTextureFromSurface(renderer._rendererPtr, surface)
    }

    // move to texture info struct
    func query() -> TextureInfo {
        var format: Uint32 = 0
        var access: Int32 = 0
        var w: Int32 = 0
        var h: Int32 = 0
        SDL_QueryTexture(self._texturePtr, &format, &access, &w, &h)
        return TextureInfo(format: PixelFormats(rawValue:format), access: TextureAccess(rawValue:access), size: Size(width: w, height: h))
    }

    func lock(rect: Rect) {
        var rect = rect
        SDL_LockTexture(self._texturePtr, &rect, self._pixelsPtr, self._pitchPtr)
    }

    func unlock() {
        SDL_UnlockTexture(self._texturePtr)
        self._pixelsPtr?.deallocate()
        self._pitchPtr?.deallocate()
        self._pixelsPtr = nil
        self._pitchPtr = nil
    }

    func update(pixels: UnsafeRawPointer, pitch: Int32) {
       //  SDL_UpdateTexture(texture: OpaquePointer!, rect: UnsafePointer<SDL_Rect>!, pixels: UnsafeRawPointer!, pitch: Int32)
    }
        
}