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
    public var toSDLBool: SDL_bool {
        return (self) ? SDL_TRUE : SDL_FALSE
    }
}