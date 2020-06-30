import CSDL2

public struct WindowFlags: OptionSet {
    public let rawValue : UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let fullscreen        = WindowFlags(rawValue: SDL_WINDOW_FULLSCREEN.rawValue)          /**< fullscreen window */
    public static let openGL            = WindowFlags(rawValue: SDL_WINDOW_OPENGL.rawValue)              /**< window usable with OpenGL context */
    public static let shown             = WindowFlags(rawValue: SDL_WINDOW_SHOWN.rawValue)               /**< window is visible */
    public static let hidden            = WindowFlags(rawValue: SDL_WINDOW_HIDDEN.rawValue)              /**< window is not visible */
    public static let borderless        = WindowFlags(rawValue: SDL_WINDOW_BORDERLESS.rawValue)          /**< no window decoration */
    public static let resizeable        = WindowFlags(rawValue: SDL_WINDOW_RESIZABLE.rawValue)           /**< window can be resized */
    public static let minimized         = WindowFlags(rawValue: SDL_WINDOW_MINIMIZED.rawValue)           /**< window is minimized */
    public static let maximized         = WindowFlags(rawValue: SDL_WINDOW_MAXIMIZED.rawValue)           /**< window is maximized */
    public static let inputGrabbed      = WindowFlags(rawValue: SDL_WINDOW_INPUT_GRABBED.rawValue)       /**< window has grabbed input focus */
    public static let inputFocus        = WindowFlags(rawValue: SDL_WINDOW_INPUT_FOCUS.rawValue)         /**< window has input focus */
    public static let mouseFocus        = WindowFlags(rawValue: SDL_WINDOW_MOUSE_FOCUS.rawValue)         /**< window has mouse focus */
    public static let fullscreenDesktop = WindowFlags(rawValue: SDL_WINDOW_FULLSCREEN_DESKTOP.rawValue)  /**< SDL_WINDOW_FULLSCREEN | 0x00001000 */
    public static let foreign           = WindowFlags(rawValue: SDL_WINDOW_FOREIGN.rawValue)             /**< window not created by SDL */
    public static let allowHIDPI        = WindowFlags(rawValue: SDL_WINDOW_ALLOW_HIGHDPI.rawValue)       /**< window should be created in high-DPI mode if supported. n macOS NSHighResolutionCapable must be set true in the application's Info.plist for this to have any effect. */
    public static let mouseCapture      = WindowFlags(rawValue: SDL_WINDOW_MOUSE_CAPTURE.rawValue)       /**< window has mouse captured (unrelated to INPUT_GRABBED) */
    public static let alwaysOnTop       = WindowFlags(rawValue: SDL_WINDOW_ALWAYS_ON_TOP.rawValue)       /**< window should always be above others */
    public static let skipTaskbar       = WindowFlags(rawValue: SDL_WINDOW_SKIP_TASKBAR.rawValue)        /**< window should not be added to the taskbar */
    public static let utility           = WindowFlags(rawValue: SDL_WINDOW_UTILITY.rawValue)             /**< window should be treated as a utility window */
    public static let tooltip           = WindowFlags(rawValue: SDL_WINDOW_TOOLTIP.rawValue)             /**< window should be treated as a tooltip */
    public static let popupMenu         = WindowFlags(rawValue: SDL_WINDOW_POPUP_MENU.rawValue)          /**< window should be treated as a popup menu */
    public static let vulkan            = WindowFlags(rawValue: SDL_WINDOW_VULKAN.rawValue)              /**< window should us vulkan */
}

extension WindowFlags: CustomStringConvertible {
    public var description: String {
        switch self {
            case .fullscreen: return "fullscreen"        
            case .openGL           : return "openGL"      
            case .shown            : return "shown"      
            case .hidden           : return "hidden"      
            case .borderless       : return "borderless"      
            case .resizeable       : return "resizeable"      
            case .minimized        : return "minimized"      
            case .maximized        : return "maximized"      
            case .inputGrabbed     : return "inputGrabbed"      
            case .inputFocus       : return "inputFocus"      
            case .mouseFocus       : return "mouseFocus"      
            case .fullscreenDesktop: return "fullscreenDesktop"      
            case .foreign          : return "foreign"      
            case .allowHIDPI       : return "allowHIDPI"      
            case .mouseCapture     : return "mouseCapture"      
            case .alwaysOnTop      : return "alwaysOnTop"      
            case .skipTaskbar      : return "skipTaskbar"      
            case .utility          : return "utility"      
            case .tooltip          : return "tooltip"      
            case .popupMenu        : return "popupMenu"      
            case .vulkan           : return "vulkan"      
            default: return "Unknown Window Flag value: \(self)"
        }   
    }
}