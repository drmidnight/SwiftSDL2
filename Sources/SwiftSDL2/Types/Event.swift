import CSDL2

typealias Event = SDL_Event

enum EventType: UInt32 {
    case quit = 0x100
    case window = 0x200
    case keyDown = 0x300
} 

extension Event {
    func isPressed(_ keyCode: KeyCode) -> Bool {
        let key = self.key.keysym.sym
        if key == keyCode.rawValue { return true }
        return false
    }

    var kind: EventType? {
        switch self.type {
            case SDL_WINDOWEVENT.rawValue: return .window
            case SDL_KEYDOWN.rawValue: return .keyDown
            case SDL_QUIT.rawValue: return .quit
            default: break
        }
        return nil
    }
}