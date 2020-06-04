public enum TextureModulate: UInt32 {
    case none  = 0x00000000  /** SDL_TEXTUREMODULATE_NONE < No modulation */
    case color = 0x00000001  /** SDL_TEXTUREMODULATE_COLOR < srcC = srcC * color */
    case alpha = 0x00000002  /** SDL_TEXTUREMODULATE_ALPHA < srcA = srcA * alpha */
}