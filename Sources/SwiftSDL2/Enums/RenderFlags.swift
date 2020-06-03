import CSDL2

public struct RendererFlags: OptionSet {
    public let rawValue : UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    static let software      = RendererFlags(rawValue: SDL_RENDERER_SOFTWARE.rawValue)       /**< The renderer is a software fallback */
    static let accelerated   = RendererFlags(rawValue: SDL_RENDERER_ACCELERATED.rawValue)    /**< The renderer uses hardware acceleration */
    static let vsync         = RendererFlags(rawValue: SDL_RENDERER_PRESENTVSYNC.rawValue)   /**< Present is synchronized with the refresh rate */
    static let targetTexture = RendererFlags(rawValue: SDL_RENDERER_TARGETTEXTURE.rawValue)  /**< The renderer supports rendering to texture */
}
