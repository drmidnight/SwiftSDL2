import CSDL2


public struct MouseState: OptionSet {
    public let rawValue : Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    private static func button(_ btn: Int32) -> Int32 {
        return (1 << ((btn)-1))
    }

    public static let left = MouseState(rawValue: SDL_BUTTON_LEFT)
    public static let middle = MouseState(rawValue: SDL_BUTTON_MIDDLE)
    public static let right = MouseState(rawValue: SDL_BUTTON_RIGHT)
    public static let x1 = MouseState(rawValue: SDL_BUTTON_X1)
    public static let x2 = MouseState(rawValue: SDL_BUTTON_X2)
  
}

extension MouseState {
    public var mask: Int32 {
        return Self.button(self.rawValue)
    }
}


public struct Mouse {
     @available(*, unavailable) private init() {}

    ///Use this function to get the window which currently has mouse focus. 
    static func getFocused() -> Window {
       return Window(ptr: SDL_GetMouseFocus())
    }
    
    ///Whether relative mouse mode is enabled. 
    static var relativeMoseModeEnabled: Bool {
        get { return SDL_GetRelativeMouseMode().toBool }
        set { SDL_SetRelativeMouseMode(newValue.SDLBoolValue) }
    }

    ///Retrieve the current state of the mouse.
    static func getState(point: Point) -> MouseState {
        var x = point.x
        var y = point.y
        return MouseState(rawValue: Int32(SDL_GetMouseState(&x, &y)))
    }

    ///Use this function to get the current state of the mouse in relation to the desktop. 
    static func getGlobalState(point: Point) -> MouseState {
        var x = point.x
        var y = point.y
        return MouseState(rawValue: Int32(SDL_GetGlobalMouseState(&x, &y)))
    }

    ///Use this function to retrieve the relative state of the mouse. 
    static func getRelativeState(point: Point) -> MouseState {
        var x = point.x
        var y = point.y
        return MouseState(rawValue: Int32(SDL_GetRelativeMouseState(&x, &y)))
    }

    static func warpMouse(in window: Window, point: Point) {
        SDL_WarpMouseInWindow(window._windowPtr, point.x, point.y)
    }

    ///Use this function to move the mouse to the given position in global screen space. 
    static func warpMouseGlobal( point: Point) throws {
        try wrap {
            SDL_WarpMouseGlobal(point.x, point.y)
        }
    }

    /// Use this function to capture the mouse and to track input outside an SDL window. 
    static func captureMouse(enabled: Bool) throws {
        try wrap {
            SDL_CaptureMouse(enabled.SDLBoolValue)
        }
    }

    /// Get/Set the active cursor
    static var cursor: Cursor {
        get { return Cursor(SDL_GetCursor()) }
        set { SDL_SetCursor(newValue._cursorPtr) }
    }

    static var defaultCursor: Cursor {
        return Cursor(SDL_GetDefaultCursor())
    }

}


// TODO: Add support for SDL_CreateCursor
// Uses MSB to make a custom cursor
public struct DataMask: Equatable {
    let data: Int8
    let mask: Int8
} 

public enum CursorType {
    case white 
    case black
    case transparent
    case inverted
}

extension CursorType: RawRepresentable  {
    public typealias RawValue = DataMask
    public init?(rawValue: RawValue) {
        switch rawValue {
            case DataMask(data: 0, mask: 1) : self = .white
            case DataMask(data: 1, mask: 1) : self = .black
            case DataMask(data: 0, mask: 0) : self = .transparent
            case DataMask(data: 1, mask: 0) : self = .inverted
            default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
            case .white: return DataMask(data: 0, mask: 1)
            case .black: return DataMask(data: 1, mask: 1)
            case .transparent: return DataMask(data: 0, mask: 0)
            case .inverted: return DataMask(data: 1, mask: 0)
        }
    }
}

public enum SystemCursor: UInt32 {
    case arrow
    case iBeam
    case wait
    case crosshair
    case waitArrow
    case sizeNWSE
    case sizeNESW
    case sizeNS
    case sizeAll
    case no
    case hand
}

public class Cursor {
    internal var _cursorPtr: OpaquePointer?

    init(_ ptr: OpaquePointer) {
        self._cursorPtr = ptr
    }

    init(systemType: SystemCursor) {
        self._cursorPtr = SDL_CreateSystemCursor(SDL_SystemCursor(rawValue: systemType.rawValue))
    }

    /** 
    - Parameter surface: surface to use for the cursor
    - Parameter point: cursor hot zone x/y
    */
    init(surface: Surface, point: Point) {
        self._cursorPtr = SDL_CreateColorCursor(surface._surfacePtr, point.x, point.y)
    }

    deinit {
        self.free()
        self._cursorPtr = nil
    }

    public func free() {
        print("Destroying Cursor")
        SDL_FreeCursor(self._cursorPtr)
    }

    public var show: Bool {
        get { return SDL_ShowCursor(-1) == 1 ? true : false }
        set { SDL_ShowCursor(newValue == true ? 1 : 0) }
    }
}

