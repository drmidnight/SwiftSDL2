import CSDL2

public typealias Event = SDL_Event

public enum EventType: UInt32 {
    case firstEvent = 0
    case quit = 0x100
    case appTerminating
    case appLowMemory
    case appWillBackground
    case appDidBackground
    case appWillForeground
    case appDidForeground

    case display = 0x150

    case window = 0x200
    case system 

    case keyDown = 0x300
    case keyUp
    case textEditing
    case textInput
    case keymapChanged

    case mouseMotion = 0x400
    case mouseBtnDown
    case mouseBtnUp
    case mouseWheel

    case joyAxisMotion = 0x600
    case joyBallMotion
    case joyHatMotion
    case joyButtonDown
    case joyButtonUp
    case joyDeviceAdded
    case joyDeviceRemoved

    case controllerAxisMotion = 0x650
    case controllerButtonDown
    case controllerButtonUp
    case controllerDeviceAdded
    case controllerDeviceRemoved
    case controllerDeviceRemapped

    case fingerDown = 0x700
    case fingerUp
    case fingerMotion

    case dollarGesture = 0x800
    case dollarRecord
    case multiGesture

    case clipboardUpdate = 0x900

    case dropFile = 0x1000
    case dropText
    case dropBegin
    case dropComplete

    case audioDeviceAdded = 0x1100
    case audioDeviceRemoved

    case sensorUpdate = 0x1200

    case renderTargetsReset = 0x2000
    case renderDeviceReset

    case userEvent = 0x8000
} 

public enum MouseBtnType: UInt8 {
    case left = 1
    case middle
    case right
    case x1
    case x2
}

// TODO: Wrap events in a command queue?
public extension Event {
    func isPressed(_ keyCode: KeyCode, repeats: Bool = false) -> Bool {
        let key = self.key.keysym.sym
        guard key == keyCode.rawValue else { return false }
        return repeats ? true : self.key.repeat == 0
    }

    func isModDown(_ keyMod: KeyMod) -> Bool {
        let modStates = KeyMod(rawValue: SDL_GetModState().rawValue)
        return modStates.contains(keyMod)
    }

    func clicked(mouseBtn: MouseBtnType, clicks: Int = 1) -> Bool {
        let key = self.button.button
        guard key == mouseBtn.rawValue else { return false }
        return self.button.clicks == clicks

    }

    var kind: EventType? {
        return EventType(rawValue: self.type)
    }

    var keyCode: KeyCode {
        let code = KeyCode(rawValue: Int(self.key.keysym.sym))
        return code
    }
}

public typealias WindowEvent = SDL_WindowEvent 
public extension WindowEvent {
    var eventID: WindowEventID {
        guard let eventType = WindowEventID(rawValue: self.event) else { return .none }
        return eventType
    }
}
