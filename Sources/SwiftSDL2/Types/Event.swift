import CSDL2

typealias Event = SDL_Event

enum EventType: UInt32 {
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

extension Event {
    func isPressed(_ keyCode: KeyCode) -> Bool {
        let key = self.key.keysym.sym
        if key == keyCode.rawValue { return true }
        return false
    }

    var kind: EventType? {
        return EventType(rawValue: self.type)
    }
}

typealias WindowEvent = SDL_WindowEvent 

extension WindowEvent {
    var eventID: WindowEventID {
        guard let eventType = WindowEventID(rawValue: self.event) else { return .none }
       return eventType
    }
}