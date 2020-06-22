import CSDL2

public enum BlendMode: UInt32 {
    case none     = 0x00000000  /** SDL_BLENDMODE_NONE < no blending dstRGBA = srcRGBA */
    case blend    = 0x00000001  /** SDL_BLENDMODE_BLEND < alpha blending dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA)) dstA = srcA + (dstA * (1-srcA)) */
    case add      = 0x00000002  /** SDL_BLENDMODE_ADD < additive blending dstRGB = (srcRGB * srcA) + dstRGB dstA = dstA */
    case modulate = 0x00000004  /** SDL_BLENDMODE_MOD < color modulate tRGB = srcRGB * dstRGB dstA = dstA */
    case invalid  = 0x7FFFFFFF  /** SDL_BLENDMODE_INVALID */
}

public extension BlendMode {
    // obviously not working, figure something out for this. Maybe make blendmode an optionSet since you can have arbitrary cases.
    public static func composeCustom(srcColorFactor: BlendFactor, dstColorFactor: BlendFactor, colorOperation: BlendOperation, srcAlphaFactor: BlendFactor, dstAlphaFactor: BlendFactor, alphaOperation: BlendOperation) -> BlendMode {
        return BlendMode(rawValue: SDL_ComposeCustomBlendMode(srcColorFactor.sdlValue, dstColorFactor.sdlValue, colorOperation.sdlValue, srcAlphaFactor.sdlValue, dstAlphaFactor.sdlValue, alphaOperation.sdlValue).rawValue) ?? none
    }    
}

public extension BlendMode {
    var toSDL: SDL_BlendMode {
        return SDL_BlendMode(rawValue: self.rawValue)
    }
}

public enum BlendOperation: UInt8 {
    case add             = 0x1  /** SDL_BLENDOPERATION_ADD  < dst + src: supported by all renderers */
    case subtract        = 0x2  /** SDL_BLENDOPERATION_SUBTRACT  < dst - src : supported by D3D9, D3D11, OpenGL, OpenGLES */
    case reverseSubtract = 0x3  /** SDL_BLENDOPERATION_REV_SUBTRACT < src - dst : supported by D3D9, D3D11, OpenGL, OpenGLES */
    case min             = 0x4  /** SDL_BLENDOPERATION_MINIMUM < min(dst, src) : supported by D3D11 */
    case max             = 0x5  /** SDL_BLENDOPERATION_MAXIMUM  < max(dst, src) : supported by D3D11 */
}

public extension BlendOperation {
    var sdlValue: SDL_BlendOperation {
        return SDL_BlendOperation(rawValue: UInt32(self.rawValue))
    }
}

public enum BlendFactor: UInt8
{
    case zero                     = 0x1  /** SDL_BLENDFACTOR_ZERO < 0, 0, 0, 0 */
    case one                      = 0x2  /** SDL_BLENDFACTOR_ONE < 1, 1, 1, 1 */
    case srcColor                 = 0x3  /** SDL_BLENDFACTOR_SRC_COLOR  < srcR, srcG, srcB, srcA */
    case oneMinusSrcColor         = 0x4  /** SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR < 1-srcR, 1-srcG, 1-srcB, 1-srcA */
    case srcAlpha                 = 0x5  /** SDL_BLENDFACTOR_SRC_ALPHA < srcA, srcA, srcA, srcA */
    case oneMinusSrcAlpha         = 0x6  /** SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA < 1-srcA, 1-srcA, 1-srcA, 1-srcA */
    case destinationColor         = 0x7  /** SDL_BLENDFACTOR_DST_COLOR < dstR, dstG, dstB, dstA */
    case oneMinusDestinationColor = 0x8  /** SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR < 1-dstR, 1-dstG, 1-dstB, 1-dstA */
    case destinationAlpha         = 0x9  /** SDL_BLENDFACTOR_DST_ALPHA < dstA, dstA, dstA, dstA */
    case oneMinusDestinationAlpha = 0xA  /** SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA < 1-dstA, 1-dstA, 1-dstA, 1-dstA */

}

public extension BlendFactor {
    var sdlValue: SDL_BlendFactor {
        return SDL_BlendFactor(rawValue: UInt32(self.rawValue))
    }
}