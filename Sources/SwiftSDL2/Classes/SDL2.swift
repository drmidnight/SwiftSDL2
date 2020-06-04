import CSDL2

struct SDLInit: OptionSet {
    var rawValue: UInt32
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    static let timer = SDLInit(rawValue: SDL_INIT_TIMER)
    static let audio = SDLInit(rawValue: SDL_INIT_AUDIO)
    static let video = SDLInit(rawValue: SDL_INIT_VIDEO) /**< SDL_INIT_VIDEO implies SDL_INIT_EVENTS */
    static let joystick = SDLInit(rawValue: SDL_INIT_JOYSTICK) /**< SDL_INIT_JOYSTICK implies SDL_INIT_EVENTS */
    static let haptic = SDLInit(rawValue: SDL_INIT_HAPTIC)
    static let gameController = SDLInit(rawValue: SDL_INIT_GAMECONTROLLER) /**< SDL_INIT_GAMECONTROLLER implies SDL_INIT_JOYSTICK */
    static let events = SDLInit(rawValue: SDL_INIT_EVENTS)
    static let sensor = SDLInit(rawValue: SDL_INIT_SENSOR)
    static let noParachute = SDLInit(rawValue: SDL_INIT_NOPARACHUTE) /**< compatibility; this flag is ignored. */
    static let everything = SDLInit(rawValue: (   SDLInit.timer.rawValue 
                                                | SDLInit.audio.rawValue  
                                                | SDLInit.joystick.rawValue 
                                                | SDLInit.haptic.rawValue 
                                                | SDLInit.gameController.rawValue 
                                                | SDLInit.events.rawValue 
                                                | SDLInit.sensor.rawValue )
                                                )

}

extension SDLInit: CustomStringConvertible {
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
    static func start(_ systems: [SDLInit]) {
        print("Initializing SDL systems:\(systems)")
        SDL_Init(flagify(systems))
    }
}