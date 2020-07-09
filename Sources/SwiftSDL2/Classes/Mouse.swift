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
    static func getFocused() -> Window {
       return Window(ptr: SDL_GetMouseFocus())
    }

    static var relativeMoseModeEnabled: Bool {
        get { return SDL_GetRelativeMouseMode().toBool }
        set { SDL_SetRelativeMouseMode(newValue.SDLBoolValue) }
    }

    static func getState(pt: Point) -> MouseState {
        var x = pt.x
        var y = pt.y
        return MouseState(rawValue: Int32(SDL_GetMouseState(&x, &y)))
    }

    static func getGlobalState(pt: Point) -> MouseState {
        var x = pt.x
        var y = pt.y
        return MouseState(rawValue: Int32(SDL_GetGlobalMouseState(&x, &y)))
    }

    static func getRelativeState(pt: Point) -> MouseState {
        var x = pt.x
        var y = pt.y
        return MouseState(rawValue: Int32(SDL_GetRelativeMouseState(&x, &y)))
    }

    static func warpMouse(in window: Window, pt: Point) {
        SDL_WarpMouseInWindow(window._windowPtr, pt.x, pt.y)
    }

    static func captureMouse(enabled: Bool) throws {
        try wrap {
            SDL_CaptureMouse(enabled.SDLBoolValue)
        }
    }

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

