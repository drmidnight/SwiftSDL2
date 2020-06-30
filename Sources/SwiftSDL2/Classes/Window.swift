import CSDL2

public class Window {
    
    internal var _windowPtr: OpaquePointer?

    init(title: String = "SDL Window", position pos: Point = .zero, size: Size, flags: [WindowFlags] = [.shown]) {
        print("Initializing window")
        _windowPtr = SDL_CreateWindow(title, Int32(pos.x), Int32(pos.y), Int32(size.width), Int32(size.height), flagify(flags)  )
    }

    deinit {
        self.destroy()
    }

    func getRenderer() -> Renderer {
        return Renderer(SDL_GetRenderer(self._windowPtr))
    }

}

public extension Window {
    func update() {
        SDL_UpdateWindowSurface( _windowPtr );
    }

    func destroy() {
        print("Destroying Window")
        SDL_DestroyWindow(_windowPtr)
        _windowPtr = nil
    }

    func getSurface() -> UnsafeMutablePointer<SDL_Surface> {
        return SDL_GetWindowSurface(_windowPtr)
    }

    func showSimpleMsg(msg: String, title: String = "", flag: MessageBoxFlags = .info) {
        SDL_ShowSimpleMessageBox(flag.rawValue, title, msg, _windowPtr)
    }

    func setFullscreen(flag: WindowFlags) {
        if flag == .fullscreen || flag == .fullscreenDesktop {
             SDL_SetWindowFullscreen(self._windowPtr, flag.rawValue) 
        }
    }

    func setIcon(surface: Surface) {
        defer{surface._surfacePtr?.deallocate()} // might not be necessary
        SDL_SetWindowIcon(self._windowPtr, surface._surfacePtr)
    }

    func maximize() {
        SDL_MaximizeWindow(self._windowPtr)
    }

    func minimize() {
        SDL_MinimizeWindow(self._windowPtr)
    }

    func restore() {
        SDL_RestoreWindow(self._windowPtr)
    }

    func raise() {
        SDL_RaiseWindow(self._windowPtr)
    }

    func show() {
        SDL_ShowWindow(self._windowPtr)
    }

    func hide() {
        SDL_HideWindow(self._windowPtr)
    }
}

public extension Window {
    var id: UInt32 {
        get {
            return SDL_GetWindowID(self._windowPtr)
        }
    }
    
    var displayIndex: Int32 {
        return SDL_GetWindowDisplayIndex(self._windowPtr)
    }

    var bordered: Bool {
        get {
            return WindowFlags(rawValue: SDL_GetWindowFlags(self._windowPtr)).contains(.borderless) == false
        }
        set {
            SDL_SetWindowBordered(self._windowPtr, newValue.SDLBoolValue)
        }
    }

    var fullscreen: Bool {
        get {
            return WindowFlags(rawValue: SDL_GetWindowFlags(self._windowPtr)).contains(.fullscreen)
        }
    }

    var resizeable: Bool {
        get {
            return WindowFlags(rawValue: SDL_GetWindowFlags(self._windowPtr)).contains(.resizeable)
        }
        set {
            SDL_SetWindowResizable(self._windowPtr, newValue.SDLBoolValue)
        }
    }

    var inputFocus: Bool {
        get {
            return WindowFlags(rawValue: SDL_GetWindowFlags(self._windowPtr)).contains(.inputFocus)
        }
        set {
            // use raise instead. Maybe dont even allow a setter? 
            if newValue == true {  SDL_SetWindowInputFocus(self._windowPtr) }
        }
    }

    var screenSaverEnabled: Bool {
        get {
            return SDL_IsScreenSaverEnabled().toBool
        }
        set {
            newValue == true ? SDL_EnableScreenSaver() : SDL_DisableScreenSaver()
        }
    }

    var windowFlags: WindowFlags {
        get {
            return WindowFlags(rawValue: SDL_GetWindowFlags(self._windowPtr))
        }
    }

    var inputGrabbed: Bool {
        get {
            return SDL_GetWindowGrab(self._windowPtr).toBool
        }
        set {
            SDL_SetWindowGrab(self._windowPtr, newValue.SDLBoolValue)
        }
    }

    var position: Point {
        get {
            var x: Int32 = 0
            var y: Int32 = 0
            SDL_GetWindowPosition(self._windowPtr, &x, &y)
            return Point(x: x, y: y)
        }
        set {
            SDL_SetWindowPosition(self._windowPtr, newValue.x, newValue.y)
        }
    }

    var size: Size {
        get {
            var w: Int32 = 0
            var h: Int32 = 0
            SDL_GetWindowSize(self._windowPtr, &w, &h)
            return Size(width: w, height: h)
        }
        set {
            SDL_SetWindowSize(self._windowPtr, Int32(newValue.width), Int32(newValue.height))
        }
    }

    var title: String {
        get {
            guard let titleValue = SDL_GetWindowTitle( self._windowPtr) else { return ""}
            defer{titleValue.deallocate()}
            return String(cString: titleValue)
        }
        set {
            SDL_SetWindowTitle(self._windowPtr, newValue)
        }
    }

    var brightness: Float {
        get {
            return SDL_GetWindowBrightness(self._windowPtr)
        }
        set {
            SDL_SetWindowBrightness(self._windowPtr, newValue)
        }
    }

    var opacity: Float {
        get {
            var opacity: Float = 0.0
            SDL_GetWindowOpacity(self._windowPtr, &opacity)
            return opacity
        }
        set {
            SDL_SetWindowOpacity(self._windowPtr, newValue)
        }
    }

    var maxSize: Size {
        get {
            var w: Int32 = 0
            var h: Int32 = 0
            SDL_GetWindowMaximumSize(self._windowPtr, &w, &h)
            return Size(width: w, height: h)
        }
        set {
            SDL_SetWindowMaximumSize(self._windowPtr, Int32(newValue.width), Int32(newValue.height))
        }
    }

    var minSize: Size {
        get {
            var w: Int32 = 0
            var h: Int32 = 0
            SDL_GetWindowMinimumSize(self._windowPtr, &w, &h)
            return Size(width: w, height: h)
        }
        set {
            SDL_SetWindowMinimumSize(self._windowPtr, Int32(newValue.width), Int32(newValue.height))
        }
    }


    typealias GammaRamp = (red: [UInt16], blue: [UInt16], green: [UInt16])
    var gammaRamp: GammaRamp {
        get {
            var red =  [UInt16](repeating: 0, count: 256)
            var green =  [UInt16](repeating: 0, count: 256)
            var blue =  [UInt16](repeating: 0, count: 256)
            SDL_GetWindowGammaRamp(self._windowPtr, &red, &green, &blue)
            return GammaRamp(red: red, blue: blue, green: green)
        }
        set {
            var red = newValue.red
            var green = newValue.green
            var blue = newValue.blue
            SDL_SetWindowGammaRamp(self._windowPtr, &red, &green, &blue)
        }
    }

}


#if os(Linux) 
public extension Window {
    var borderSize: Edges {
            get {
                var top: Int32 = 0
                var left: Int32 = 0
                var bottom: Int32 = 0
                var right: Int32 = 0

                SDL_GetWindowBordersSize(self._windowPtr, &top, &left, &bottom, &right)
                return Edges(top: Int(top), left: Int(left), bottom: Int(bottom), right: Int(right))
            }
    }
}
#endif
