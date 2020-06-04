import CSDL2

struct SDLSystem: OptionSet {
    var rawValue: UInt32
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    static let timer = SDLSystem(rawValue: SDL_INIT_TIMER)
    static let audio = SDLSystem(rawValue: SDL_INIT_AUDIO)
    static let video = SDLSystem(rawValue: SDL_INIT_VIDEO) /**< SDL_INIT_VIDEO implies SDL_INIT_EVENTS */
    static let joystick = SDLSystem(rawValue: SDL_INIT_JOYSTICK) /**< SDL_INIT_JOYSTICK implies SDL_INIT_EVENTS */
    static let haptic = SDLSystem(rawValue: SDL_INIT_HAPTIC)
    static let gameController = SDLSystem(rawValue: SDL_INIT_GAMECONTROLLER) /**< SDL_INIT_GAMECONTROLLER implies SDL_INIT_JOYSTICK */
    static let events = SDLSystem(rawValue: SDL_INIT_EVENTS)
    static let sensor = SDLSystem(rawValue: SDL_INIT_SENSOR)
    static let noParachute = SDLSystem(rawValue: SDL_INIT_NOPARACHUTE) /**< compatibility; this flag is ignored. */
    static let everything = SDLSystem(rawValue: (   SDLSystem.timer.rawValue 
                                                | SDLSystem.audio.rawValue  
                                                | SDLSystem.joystick.rawValue 
                                                | SDLSystem.haptic.rawValue 
                                                | SDLSystem.gameController.rawValue 
                                                | SDLSystem.events.rawValue 
                                                | SDLSystem.sensor.rawValue )
                                                )

}

extension SDLSystem: CustomStringConvertible {
    var description: String {
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

class SDL {
    static func initialize(_ systems: [SDLSystem]) {
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
}