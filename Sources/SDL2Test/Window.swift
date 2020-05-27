import CSDL2                           
class Window {
    var _windowPtr: OpaquePointer?

    private func flagify(_ flags: [WindowFlags]) -> UInt32 {
        var result: Uint32 = 0
        flags.forEach { result = result | $0.rawValue }
        return result
    }

    init(title: String = "SDL Window", position pos: Point = .zero, size: Size, flags: [WindowFlags] = [.shown]) {
        print("Initializing window")
        _windowPtr = SDL_CreateWindow(title, Int32(pos.x), Int32(pos.y), Int32(size.width), Int32(size.height), flagify(flags)  )
    }

    deinit {
        self.destroy()
    }

    func update() {
        SDL_UpdateWindowSurface( _windowPtr );
    }

    func destroy() {
        print("Destroying Window")
        SDL_DestroyWindow(_windowPtr)
    }

    func getSurface() -> UnsafeMutablePointer<SDL_Surface> {
        return SDL_GetWindowSurface(_windowPtr)
    }

    func showMsg() {
        SDL_ShowSimpleMessageBox(UInt32(0), "test", "message", _windowPtr)
    }
}