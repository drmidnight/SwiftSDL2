import CSDL2

public enum RendererFlags: UInt32 {
    case software =      0x00000001     //SDL_RENDERER_SOFTWARE       /**< The renderer is a software fallback */
    case accelerated =   0x00000002  //SDL_RENDERER_ACCELERATED       /**< The renderer uses hardware acceleration */
    case vsync =         0x00000004        //SDL_RENDERER_PRESENTVSYNC      /**< Present is synchronized with the refresh rate */
    case targetTexture = 0x0000000 // SDL_RENDERER_TARGETTEXTURE 
}

class Renderer {
    var _rendererPtr: OpaquePointer?
    
    func render(_ renderClosure: (Renderer?)->()) {
        renderClosure(self)
        SDL_RenderPresent(self._rendererPtr)
    }

    init(window: Window, flags: [RendererFlags] = [.accelerated]) {
        self._rendererPtr = SDL_CreateRenderer(window._windowPtr, -1, flagify(flags))
    }

    deinit {
        print("Destroying renderer")
        SDL_DestroyRenderer(self._rendererPtr)
        _rendererPtr = nil
    }

    var drawColor: Color {
        get {
            var r: UInt8 = 0
            var g: UInt8 = 0
            var b: UInt8 = 0
            var a: UInt8 = 0
            SDL_GetRenderDrawColor(self._rendererPtr, &r, &g, &b, &a)
            return Color(r: r, g: g, b: b, a: a)
        }
        set {
            SDL_SetRenderDrawColor(self._rendererPtr, newValue.r, newValue.g, newValue.b, newValue.a)
        }
    }
}

extension Renderer {
    func clear() {
        SDL_RenderClear( self._rendererPtr )
    }

    func fillRect(_ rect: Rect) {
        var _sdlRect = SDL_Rect(x: Int32(rect.x), y: Int32(rect.y), w: Int32(rect.width), h: Int32(rect.height))
        SDL_RenderFillRect(self._rendererPtr, &_sdlRect);		
    }
}

extension Renderer {
    var rendererInfo: SDL_RendererInfo {
        var info = SDL_RendererInfo()
        SDL_GetRendererInfo(self._rendererPtr, &info)
        return info
    }

}