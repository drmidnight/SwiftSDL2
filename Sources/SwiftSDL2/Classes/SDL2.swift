import CSDL2

public struct SDLSystem: OptionSet {
    public var rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    static let timer          = SDLSystem(rawValue: SDL_INIT_TIMER)
    static let audio          = SDLSystem(rawValue: SDL_INIT_AUDIO)
    static let video          = SDLSystem(rawValue: SDL_INIT_VIDEO)                /**< SDL_INIT_VIDEO implies SDL_INIT_EVENTS */
    static let joystick       = SDLSystem(rawValue: SDL_INIT_JOYSTICK)             /**< SDL_INIT_JOYSTICK implies SDL_INIT_EVENTS */
    static let haptic         = SDLSystem(rawValue: SDL_INIT_HAPTIC)
    static let gameController = SDLSystem(rawValue: SDL_INIT_GAMECONTROLLER)       /**< SDL_INIT_GAMECONTROLLER implies SDL_INIT_JOYSTICK */
    static let events         = SDLSystem(rawValue: SDL_INIT_EVENTS)
    static let sensor         = SDLSystem(rawValue: SDL_INIT_SENSOR)
    static let noParachute    = SDLSystem(rawValue: SDL_INIT_NOPARACHUTE)          /**< compatibility; this flag is ignored. */
    static let everything     = SDLSystem(rawValue: (   
                                                    SDLSystem.timer.rawValue 
                                                    | SDLSystem.audio.rawValue  
                                                    | SDLSystem.joystick.rawValue 
                                                    | SDLSystem.haptic.rawValue 
                                                    | SDLSystem.gameController.rawValue 
                                                    | SDLSystem.events.rawValue 
                                                    | SDLSystem.sensor.rawValue 
                                                )
                                         )

}

extension SDLSystem: CustomStringConvertible {
    public var description: String {
        switch self {
            case .timer         : return "timer"
            case .audio         : return "audio"
            case .video         : return "video"
            case .joystick      : return "joystick"
            case .haptic        : return "haptic"
            case .gameController: return "gameController"
            case .events        : return "events"
            case .sensor        : return "sensor"
            case .noParachute   : return "noParachute"
            case .everything    : return "everything"
            default             : return "unknown system"
        }
    }
}

public struct SDL {
    @available(*, unavailable) private init() {}
    static func initialize(_ systems: [SDLSystem] = [.everything]) {
        print("Initializing SDL systems:\(systems)")
        SDL_Init(flagify(systems))
    }

    static func start(subSystems: [SDLSystem]) {
        print("Initializing SDL subsystems:\(subSystems)")
        SDL_InitSubSystem(flagify(subSystems))
    }

    static func quit() {
        print("Quitting SDL")
        SDL_Quit()
    }

    static func quit(subSystems: [SDLSystem]) {
        print("Quitting SDL subsystems:\(subSystems)")
        SDL_QuitSubSystem(flagify(subSystems))
    }

    static func calculateGammaRamp(_ gamma: Float) -> [UInt16] {
        var ramp = [UInt16](repeating: 0, count: 256)
        SDL_CalculateGammaRamp(gamma, &ramp)
        return ramp
    }

    static func wasInit(system: SDLSystem) -> Bool {
        let flagValue = SDL_WasInit(0)
        return (flagValue & system.rawValue) ==  system.rawValue 
    }
}

// Potentially unecessary/unsafe functions see SDL docs regarding these
extension SDL {
    static func setMainReady() {
        SDL_SetMainReady()
    }
}


// Hint functions
extension SDL {
    typealias HintCallback = SDL_HintCallback
    enum HintPriority: UInt32 {
        case `default` = 0
        case normal = 1
        case `override` = 2
    }

    static func setHint(hint: String, value: Int) {
        var valPtr = Int8(value)
        SDL_SetHint(hint, &valPtr)
    }

     static func setHint(hint: String, value: Int, priority: HintPriority) {
        var valPtr = Int8(value)
        SDL_SetHintWithPriority(hint, &valPtr, SDL_HintPriority(rawValue:priority.rawValue))
    }

    static func getHint(hint: String) -> Int8 {
        var result = SDL_GetHint(hint)
        defer{ result?.deallocate()}
        return result?.pointee ?? 0
    }

    static func getHint(hint: String) -> Bool {
        let result = SDL_GetHintBoolean(hint, false.SDLBoolValue)
        return result.toBool
    }

    static func clearHints() {
        SDL_ClearHints()
    }

    // Wrap hint callback more cleanly.
    static func addHintCallback(name: String, callback: HintCallback?, userData: UnsafeMutableRawPointer) {
        SDL_AddHintCallback(name, callback, userData)
    }

    static func deleteHintCallback(name: String, callback: HintCallback?, userData: UnsafeMutableRawPointer){
        SDL_DelHintCallback(name, callback, userData)
    }
    
}

extension SDL {
    // maybe auto-initialize sdl if it hasnt been already?
    /// Runs the passed in closure until a return and will then proceed to call SDL_Quit()
    static func main(_ closure: ()->()) {
        defer{ SDL.quit()}
        closure()
    }
}