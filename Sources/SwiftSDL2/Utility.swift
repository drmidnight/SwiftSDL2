import CSDL2

public struct Vector2<T> {
    var x: T
    var y: T
}


extension SDL_bool {
    public var toBool: Bool {
        return (self == SDL_TRUE) ? true : false
    }
}

extension Bool {
    public var SDLBoolValue: SDL_bool {
        return (self) ? SDL_TRUE : SDL_FALSE
    }
}

public func flagify<T:RawRepresentable>(_ flags: [T]) -> UInt32 where T.RawValue==UInt32 {
    var result: Uint32 = 0
    flags.forEach { result = result | $0.rawValue }
    return result
}

public func flagify<T:RawRepresentable>(_ flags: [T]) -> Int32 where T.RawValue==Int32 {
    var result: Int32 = 0
    flags.forEach { result = result | $0.rawValue }
    return result
}

struct SDLError: Error {
    let message: String
}

func wrap(_ fn: () -> Int32) throws {
    let result = fn()
    print(result)
    guard result >= 0 else {
        var message = "Unknown error"
        if let err = SDL_GetError() {
            message = String(cString: err)
        }
        throw SDLError(message: message)
    }
}

