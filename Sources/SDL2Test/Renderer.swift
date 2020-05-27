import CSDL2
class Renderer {
    var _rendererPtr: OpaquePointer?
    func render(_ renderClosure: (Renderer?)->()) {
        renderClosure(self)
        SDL_RenderPresent(self._rendererPtr)
    }

    init(window: Window) {
        self._rendererPtr = SDL_CreateRenderer(window._windowPtr, -1, 0x00000002)
    }

    deinit {
        print("Destroying renderer")
        SDL_DestroyRenderer(self._rendererPtr)
    }
}

extension Renderer {
    func setDrawColor(_ color: Color) {
        SDL_SetRenderDrawColor(self._rendererPtr, color.r, color.g, color.b, color.a)
    }

    func clear() {
        SDL_RenderClear( self._rendererPtr )
    }

    func fillRect(_ rect: Rect) {
        var _sdlRect = SDL_Rect(x: Int32(rect.x), y: Int32(rect.y), w: Int32(rect.width), h: Int32(rect.height))
        SDL_RenderFillRect(self._rendererPtr, &_sdlRect);		
    }
}