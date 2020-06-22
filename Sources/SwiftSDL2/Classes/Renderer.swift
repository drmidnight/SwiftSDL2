import CSDL2

class Renderer {
    var _rendererPtr: OpaquePointer?

    init(window: Window, flags: [RendererFlags] = [.accelerated], driverIndex: Int32 = -1) {
        self._rendererPtr = SDL_CreateRenderer(window._windowPtr, driverIndex, flagify(flags))
    }

    init(_ pointer: OpaquePointer) {
        self._rendererPtr = pointer
    }

    deinit {
        self.destroy()
    }

    func destroy() {
        print("Destroying renderer")
        SDL_DestroyRenderer(self._rendererPtr)
        self._rendererPtr = nil
    }

}

extension Renderer {
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

    var blendMode: BlendMode {
        get {
            var blendMode: SDL_BlendMode = SDL_BLENDMODE_NONE
            SDL_GetRenderDrawBlendMode(self._rendererPtr, &blendMode)
            return BlendMode(rawValue: blendMode.rawValue) ?? .none
        }
        set {
            SDL_SetRenderDrawBlendMode(self._rendererPtr, newValue.toSDL)
        }
    }

    var viewPort: Rect {
        get {
            var rect = Rect()
            SDL_RenderGetViewport(self._rendererPtr, &rect)
            return rect
        }
        set {
            var rect = newValue
            SDL_RenderSetViewport(self._rendererPtr, &rect)
        }
    }

    var clipRect: Rect {
        get {
            var rect = Rect()
            SDL_RenderGetClipRect(self._rendererPtr, &rect)
            return rect
        }
        set {
            var rect = newValue
            SDL_RenderSetClipRect(self._rendererPtr, &rect)
        }
    }

    var scale: Vector2<Float> {
        get{
            var x: Float = 0.0
            var y: Float = 0.0
            SDL_RenderGetScale(self._rendererPtr, &x, &y)
            return Vector2<Float>(x: x, y: y)
        }
        set {
            SDL_RenderSetScale(self._rendererPtr, newValue.x, newValue.y)
        }
    }

    var integerScale: Bool {
        get {
            return SDL_RenderGetIntegerScale(self._rendererPtr).toBool
        }
        set {
            SDL_RenderSetIntegerScale(self._rendererPtr, newValue.SDLBoolValue)
        }
    }

    var outputSize: Size {
        get {
            var w: Int32 = 0
            var h: Int32 = 0
            SDL_GetRendererOutputSize(self._rendererPtr, &w, &h)
            return Size(width: w, height: h)
        }
    }

   // wrap with RendererInfo type
    var rendererInfo: SDL_RendererInfo {
        var info = SDL_RendererInfo()
        SDL_GetRendererInfo(self._rendererPtr, &info)
        return info
    }

    var logicalSize: Size {
        get {
            var w: Int32 = 0
            var h: Int32 = 0
            SDL_RenderGetLogicalSize(self._rendererPtr, &w, &h)
            return Size(width: w, height: h)
        }
        set {
            SDL_RenderSetLogicalSize(self._rendererPtr, Int32(newValue.width), Int32(newValue.height))
        }
    }

    var clipEnabled: Bool {
        get {
            return SDL_RenderIsClipEnabled(self._rendererPtr).toBool
        }
    }

    var renderTarget: Texture {
        get {
            return Texture(pointer: SDL_GetRenderTarget(self._rendererPtr))
        }
        set {
            SDL_SetRenderTarget(self._rendererPtr, newValue._texturePtr)
        }
    }

    var renderTargetSupported: Bool {
        get {
            return SDL_RenderTargetSupported(self._rendererPtr).toBool
        }
    }

}
extension Renderer {

    func render(_ renderClosure: (Renderer?)->()) {
        renderClosure(self)
    }

    func present() {
        SDL_RenderPresent(self._rendererPtr)
    }

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

    func drawLine(start: Point, end: Point, color: Color) {
        self.drawColor = color
        SDL_RenderDrawLine(self._rendererPtr, start.x, start.y, end.x, end.y)
    }

    func drawLines(points: [Point], color: Color) {
        var points = points
        self.drawColor = color
        SDL_RenderDrawLines(self._rendererPtr, &points, Int32(points.endIndex))
    }

    func drawPoint(_ point: Point, color: Color) {
        self.drawColor = color
        SDL_RenderDrawPoint(self._rendererPtr, point.x, point.y)
    }

    func drawPoints(points: [Point], color: Color) {
        var points = points
        self.drawColor = color
        SDL_RenderDrawPoints(self._rendererPtr, &points, Int32(points.endIndex))
    }
}

extension Renderer {
    func renderCopy(texture: Texture, srcRect: Rect, dstRect: Rect) {
        var src = srcRect
        var dst = dstRect
        SDL_RenderCopy(self._rendererPtr, texture._texturePtr, &src, &dst)
    }

    func renderCopy(texture: Texture, srcRect: Rect) {
        var src = srcRect
        SDL_RenderCopy(self._rendererPtr, texture._texturePtr, &src, nil)
    }

    func renderCopy(texture: Texture, dstRect: Rect) {
        var dst = dstRect
        SDL_RenderCopy(self._rendererPtr, texture._texturePtr, nil, &dst)
    }

    func renderCopy(texture: Texture) {
        SDL_RenderCopy(self._rendererPtr, texture._texturePtr, nil, nil)
    }

    func renderCopyEx(texture: Texture, srcRect: Rect, dstRect: Rect, angle: Double, center: Point, flip: RendererFlip) {
        var src = srcRect
        var dst = dstRect
        var center = center

        SDL_RenderCopyEx(self._rendererPtr, texture._texturePtr, &src, &dst, angle, &center, flip.sdlValue)
    }
}
