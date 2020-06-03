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


    init(renderer: Renderer, image: String) {
        let surfacePtr: UnsafeMutablePointer<SDL_Surface>? = IMG_Load(image)
        self._texturePtr = Texture.createFromSurface(renderer: renderer, surface: surfacePtr)

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
      // wrap Surface next
    static func createFromSurface(renderer: Renderer, surface:  UnsafeMutablePointer<SDL_Surface>?) -> OpaquePointer? {
        return SDL_CreateTextureFromSurface(renderer._rendererPtr, surface)
    }

    func lock(rect: Rect) {
        var rect = rect
        SDL_LockTexture(self._texturePtr, &rect, self._pixelsPtr, self._pitchPtr)
    }

    func unlock() {
        SDL_UnlockTexture(self._texturePtr)
        self._pixelsPtr = nil
        self._pitchPtr = nil
    }
        
}