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

    func showMsg() {
        SDL_ShowSimpleMessageBox(UInt32(0), "test", "message", _windowPtr)
    }
}

extension Window {
#if os(Linux) 
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
#endif

    var bordered: Bool {
        get {
            return (SDL_GetWindowFlags(self._windowPtr) & WindowFlags.borderless.rawValue) == WindowFlags.borderless.rawValue
        }
        set {
            SDL_SetWindowBordered(self._windowPtr, newValue.SDLBoolValue)
        }
    }

    var windowFlags: [WindowFlags] {
        get {
            var flags = [WindowFlags]()
            let flagValue = SDL_GetWindowFlags(self._windowPtr)
            if (flagValue & WindowFlags.fullscreen.rawValue) == WindowFlags.fullscreen.rawValue {flags.append(.fullscreen)}
            if (flagValue & WindowFlags.openGL.rawValue) == WindowFlags.openGL.rawValue {flags.append(.openGL)}
            if (flagValue & WindowFlags.shown.rawValue) == WindowFlags.shown.rawValue {flags.append(.shown)}
            if (flagValue & WindowFlags.hidden.rawValue) == WindowFlags.hidden.rawValue {flags.append(.hidden)}
            if (flagValue & WindowFlags.borderless.rawValue) == WindowFlags.borderless.rawValue {flags.append(.borderless)}
            if (flagValue & WindowFlags.resizeable.rawValue) == WindowFlags.resizeable.rawValue {flags.append(.resizeable)}
            if (flagValue & WindowFlags.minimized.rawValue) == WindowFlags.minimized.rawValue {flags.append(.minimized)}
            if (flagValue & WindowFlags.maximized.rawValue) == WindowFlags.maximized.rawValue {flags.append(.maximized)}
            if (flagValue & WindowFlags.inputGrabbed.rawValue) == WindowFlags.inputGrabbed.rawValue {flags.append(.inputGrabbed)}
            if (flagValue & WindowFlags.inputFocus.rawValue) == WindowFlags.inputFocus.rawValue {flags.append(.inputFocus)}
            if (flagValue & WindowFlags.mouseFocus.rawValue) == WindowFlags.mouseFocus.rawValue {flags.append(.mouseFocus)}
            if (flagValue & WindowFlags.fullscreenDesktop.rawValue) == WindowFlags.fullscreenDesktop.rawValue {flags.append(.fullscreenDesktop)}
            if (flagValue & WindowFlags.foreign.rawValue) == WindowFlags.foreign.rawValue {flags.append(.foreign)}
            if (flagValue & WindowFlags.allowHIDPI.rawValue) == WindowFlags.allowHIDPI.rawValue {flags.append(.allowHIDPI)}
            if (flagValue & WindowFlags.mouseCapture.rawValue) == WindowFlags.mouseCapture.rawValue {flags.append(.mouseCapture)}
            if (flagValue & WindowFlags.vulkan.rawValue) == WindowFlags.vulkan.rawValue {flags.append(.vulkan)}
#if os(Linux) 
            if (flagValue & WindowFlags.alwaysOnTop.rawValue) == WindowFlags.alwaysOnTop.rawValue {flags.append(.alwaysOnTop)}
            if (flagValue & WindowFlags.skipTaskbar.rawValue) == WindowFlags.skipTaskbar.rawValue {flags.append(.skipTaskbar)}
            if (flagValue & WindowFlags.utility.rawValue) == WindowFlags.utility.rawValue {flags.append(.utility)}
            if (flagValue & WindowFlags.tooltip.rawValue) == WindowFlags.tooltip.rawValue {flags.append(.tooltip)}
            if (flagValue & WindowFlags.popupMenu.rawValue) == WindowFlags.popupMenu.rawValue {flags.append(.popupMenu)}
#endif
            return flags
        }
    }
}