import CSDL2

public enum RendererFlags: UInt32 {
    case software =      0x00000001     //SDL_RENDERER_SOFTWARE       /**< The renderer is a software fallback */
    case accelerated =   0x00000002  //SDL_RENDERER_ACCELERATED       /**< The renderer uses hardware acceleration */
    case vsync =         0x00000004        //SDL_RENDERER_PRESENTVSYNC      /**< Present is synchronized with the refresh rate */
    case targetTexture = 0x0000000 // SDL_RENDERER_TARGETTEXTURE 
}

class Renderer {
    var _rendererPtr: OpaquePointer?

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

    var blendMode: SDL_BlendMode {
        get {
            var blendMode: SDL_BlendMode = SDL_BLENDMODE_NONE
            SDL_GetRenderDrawBlendMode(self._rendererPtr, &blendMode)
            return blendMode
        }
        set {
            SDL_SetRenderDrawBlendMode(self._rendererPtr, newValue)
        }
    }

    init(window: Window, flags: [RendererFlags] = [.accelerated]) {
        self._rendererPtr = SDL_CreateRenderer(window._windowPtr, -1, flagify(flags))
    }

    deinit {
      self.destroy()
    }

    func destroy() {
        print("Destroying renderer")
        SDL_DestroyRenderer(self._rendererPtr)
        _rendererPtr = nil
    }

    func render(_ renderClosure: (Renderer?)->()) {
        renderClosure(self)
        SDL_RenderPresent(self._rendererPtr)
    }

  
}

extension Renderer {
    func clear() {
        SDL_RenderClear( self._rendererPtr )
    }

    func fillRect(_ rect: Rect) {
        var _sdlRect = rect
        SDL_RenderFillRect(self._rendererPtr, &_sdlRect);		
    }

    func fillRects(_ rects: [Rect]) {
        var fillRects: [SDL_Rect] = rects
        SDL_RenderFillRects(self._rendererPtr, &fillRects, Int32(fillRects.endIndex))
    }

    func drawRect(_ rect: Rect) {
        var _sdlRect = rect
        SDL_RenderDrawRect(self._rendererPtr, &_sdlRect);		
    }

    func drawRects(_ rects: [Rect]) {
        var fillRects: [SDL_Rect] = rects
        SDL_RenderDrawRects(self._rendererPtr, &fillRects, Int32(fillRects.endIndex))
    }
}

extension Renderer {
    // wrap with RendererInfo type
    var rendererInfo: SDL_RendererInfo {
        var info = SDL_RendererInfo()
        SDL_GetRendererInfo(self._rendererPtr, &info)
        return info
    }

}