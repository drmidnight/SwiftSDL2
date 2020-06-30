import CSDL2

public struct SDL {
    @available(*, unavailable) private init() {}
}

public extension SDL {
    static func initialize(_ systems: [SDLSystem] = [.everything]) {
        do {
            try wrap {  SDL_Init(flagify(systems)) }
        } catch {
            print(error)
        }
        print("Initializing SDL systems:\(systems)")
       
    }

    static func start(subSystems: [SDLSystem]) {
        print("Initializing SDL subsystems:\(subSystems)")
        SDL_InitSubSystem(flagify(subSystems))
    }

    static func initialize(imageSupport imageType: [ImageType]) {
        print("Initializing SDL Image support for: \(imageType)")
        IMG_Init(flagify(imageType))
    }

    static func quit() {
        print("Quitting SDL")
        SDL_Quit()
    }

    static func quit(subSystems: [SDLSystem]) {
        print("Quitting SDL subsystems:\(subSystems)")
        SDL_QuitSubSystem(flagify(subSystems))
    }

    static func wasInit(system: SDLSystem) -> Bool {
        return SDLSystem(rawValue: SDL_WasInit(0)).contains(system)
    }


    static func calculateGammaRamp(_ gamma: Float) -> [UInt16] {
        var ramp = [UInt16](repeating: 0, count: 256)
        SDL_CalculateGammaRamp(gamma, &ramp)
        return ramp
    }

    typealias Version = SDL_version
    static var version: Version {
        var ver = Version()
        SDL_GetVersion(&ver)
        return ver
    }

    static var revision: String {
        guard var strPtr = SDL_GetRevision() else { return ""}
        defer { strPtr.deallocate()}
        return String(cString:strPtr)
    }

    static var revisionNumber: Int32 {
        return SDL_GetRevisionNumber() 
    }
}

extension SDL.Version: CustomStringConvertible {
    public var description: String {
        return "SDL Version: \(self.major).\(self.minor).\(self.patch)"
    }
}

// Potentially unecessary/unsafe functions see SDL docs regarding these
public extension SDL {
    static func setMainReady() {
        SDL_SetMainReady()
    }
}

// Hint functions
public extension SDL {
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

    static func getPerformanceCounter() -> Int {
        return Int(SDL_GetPerformanceCounter())
    }
    
}

public extension SDL {
    // maybe auto-initialize sdl if it hasnt been already?
    static func printError() {
        print(String(cString: SDL_GetError()))
    }

    static func pollEvents(_ closure:(SDL_Event)->()) {
        var event = Event()
        while SDL_PollEvent(&event) != 0 {
            closure(event)
        }
    }
}

public extension SDL {
    // TODO: Add priority wrapper and category wrapper.
    // maybe ditch sdl log and use log library from my old swiftnio project.
    static func Log(cat: Int = SDL_LOG_CATEGORY_SYSTEM, priority: SDL_LogPriority = SDL_LOG_PRIORITY_INFO, _ message: String, format: String = "%s") {
        message.withCString { message in
            withVaList([message]) {
                SDL_LogMessageV(Int32(cat), priority, format, $0)
            }
        }
    }
}