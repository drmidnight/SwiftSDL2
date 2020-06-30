import CSDL2
public enum RendererFlip: UInt32 {
    case none       = 0x00000000  /** SDL_FLIP_NONE < Do not flip */
    case horizontal = 0x00000001  /** SDL_FLIP_HORIZONTAL < flip horizontally */
    case vertical   = 0x00000002  /** SDL_FLIP_VERTICAL < flip vertically */
}

public extension RendererFlip {
    var sdlValue: SDL_RendererFlip {
        return SDL_RendererFlip(rawValue: UInt32(self.rawValue))
    }
}