import CSDL2

public struct SDLSystem: OptionSet {
    public var rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let  timer          = SDLSystem(rawValue: SDL_INIT_TIMER)
    public static let  audio          = SDLSystem(rawValue: SDL_INIT_AUDIO)
    public static let  video          = SDLSystem(rawValue: SDL_INIT_VIDEO)                /**< SDL_INIT_VIDEO implies SDL_INIT_EVENTS */
    public static let  joystick       = SDLSystem(rawValue: SDL_INIT_JOYSTICK)             /**< SDL_INIT_JOYSTICK implies SDL_INIT_EVENTS */
    public static let  haptic         = SDLSystem(rawValue: SDL_INIT_HAPTIC)
    public static let  gameController = SDLSystem(rawValue: SDL_INIT_GAMECONTROLLER)       /**< SDL_INIT_GAMECONTROLLER implies SDL_INIT_JOYSTICK */
    public static let  events         = SDLSystem(rawValue: SDL_INIT_EVENTS)
    public static let  sensor         = SDLSystem(rawValue: SDL_INIT_SENSOR)
    public static let  noParachute    = SDLSystem(rawValue: SDL_INIT_NOPARACHUTE)          /**< compatibility; this flag is ignored. */
    public static let  everything     = SDLSystem(rawValue: (   
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
