import CSDL2       

public func flagify<T:RawRepresentable>(_ flags: [T]) -> UInt32 where T.RawValue==UInt32 {
    var result: Uint32 = 0
    flags.forEach { result = result | $0.rawValue }
    return result
}

public enum WindowFlags: UInt32 {
    case fullscreen        = 0x00000001    /**< fullscreen window */
    case openGL            = 0x00000002    /**< window usable with OpenGL context */
    case shown             = 0x00000004    /**< window is visible */
    case hidden            = 0x00000008    /**< window is not visible */
    case borderless        = 0x00000010    /**< no window decoration */
    case resizeable        = 0x00000020    /**< window can be resized */
    case minimized         = 0x00000040    /**< window is minimized */
    case maximized         = 0x00000080    /**< window is maximized */
    case inputGrabbed      = 0x00000100    /**< window has grabbed input focus */
    case inputFocus        = 0x00000200    /**< window has input focus */
    case mouseFocus        = 0x00000400    /**< window has mouse focus */
    case fullscreenDesktop = 0x00001001    /**< SDL_WINDOW_FULLSCREEN | 0x00001000 */
    case foreign           = 0x00000800    /**< window not created by SDL */
    case allowHIDPI        = 0x00002000    /**< window should be created in high-DPI mode if supported.
                                                On macOS NSHighResolutionCapable must be set true in the
                                                application's Info.plist for this to have any effect. */
    case mouseCapture      = 0x00004000    /**< window has mouse captured (unrelated to INPUT_GRABBED) */
    case alwaysOnTop       = 0x00008000    /**< window should always be above others */
    case skipTaskbar       = 0x00010000    /**< window should not be added to the taskbar */
    case utility           = 0x00020000    /**< window should be treated as a utility window */
    case tooltip           = 0x00040000    /**< window should be treated as a tooltip */
    case popupMenu         = 0x00080000    /**< window should be treated as a popup menu */
    case vulkan            = 0x10000000    /**< window should us vulkan */
}

public enum WindowEventID: UInt8 {
    case none           /**< Never used */
    case shown          /**< Window has been shown */
    case hidden         /**< Window has been hidden */
    case exposed        /**< Window has been exposed and should be redrawn */
    case moved          /**< Window has been moved to data1, data2 */
    case resized        /**< Window has been resized to data1xdata2 */
    case sizeChanged    /**< The window size has changed, either as a result of an API call or through the ystem or user changing the window size. */
    case minimized      /**< Window has been minimized */
    case maximized      /**< Window has been maximized */
    case restored       /**< Window has been restored to normal size  and position */
    case enter          /**< Window has gained mouse focus */
    case leave          /**< Window has lost mouse focus */
    case focusGained    /**< Window has gained keyboard focus */
    case focusLost      /**< Window has lost keyboard focus */
    case closed         /**< The window manager requests that the window be closed */
    case takeFocus      /**< Window is being offered a focus (should SetWindowInputFocus() on itself or a subwindow, or ignore) */
    case hitTest        /**< Window had a hit test that wasn't SDL_HITTEST_NORMAL. */
} 

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