import CSDL2

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

    static func wasInit(system: SDLSystem) -> Bool {
        let flagValue = SDL_WasInit(0)
        return (flagValue & system.rawValue) ==  system.rawValue 
    }


    static func calculateGammaRamp(_ gamma: Float) -> [UInt16] {
        var ramp = [UInt16](repeating: 0, count: 256)
        SDL_CalculateGammaRamp(gamma, &ramp)
        return ramp
    }

    typealias SDLVersion = SDL_version
    static var version: SDLVersion {
        var ver = SDLVersion()
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

extension SDL.SDLVersion: CustomStringConvertible {
    public var description: String {
        return "SDL Version: \(self.major).\(self.minor).\(self.patch)"
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