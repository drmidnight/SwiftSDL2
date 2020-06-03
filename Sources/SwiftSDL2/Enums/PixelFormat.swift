import CSDL2

// maybe think about making these all uppercase?
struct PixelFormat: OptionSet
{    
    let rawValue : UInt32
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    static let unknown     = PixelFormat(rawValue: SDL_PIXELFORMAT_UNKNOWN.rawValue)
    static let index1lsb   = PixelFormat(rawValue: SDL_PIXELFORMAT_INDEX1LSB.rawValue)
    static let index1msb   = PixelFormat(rawValue: SDL_PIXELFORMAT_INDEX1MSB.rawValue)
    static let index4lsb   = PixelFormat(rawValue: SDL_PIXELFORMAT_INDEX4LSB.rawValue)
    static let index4msb   = PixelFormat(rawValue: SDL_PIXELFORMAT_INDEX4MSB.rawValue)
    static let index8      = PixelFormat(rawValue: SDL_PIXELFORMAT_INDEX8.rawValue)
    static let rgb332      = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB332.rawValue)
    static let rgb444      = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB444.rawValue)
    static let rgb555      = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB555.rawValue)
    static let bgr555      = PixelFormat(rawValue: SDL_PIXELFORMAT_BGR555.rawValue)
    static let argb4444    = PixelFormat(rawValue: SDL_PIXELFORMAT_ARGB4444.rawValue)
    static let rgba4444    = PixelFormat(rawValue: SDL_PIXELFORMAT_RGBA4444.rawValue)
    static let abgr4444    = PixelFormat(rawValue: SDL_PIXELFORMAT_ABGR4444.rawValue)
    static let bgra4444    = PixelFormat(rawValue: SDL_PIXELFORMAT_BGRA4444.rawValue)
    static let argb1555    = PixelFormat(rawValue: SDL_PIXELFORMAT_ARGB1555.rawValue)
    static let rgba555     = PixelFormat(rawValue: SDL_PIXELFORMAT_RGBA5551.rawValue)
    static let abgr1555    = PixelFormat(rawValue: SDL_PIXELFORMAT_ABGR1555.rawValue)
    static let bgra5551    = PixelFormat(rawValue: SDL_PIXELFORMAT_BGRA5551.rawValue)
    static let rgb565      = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB565.rawValue)
    static let bgr565      = PixelFormat(rawValue: SDL_PIXELFORMAT_BGR565.rawValue)
    static let rgb24       = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB24.rawValue)
    static let bgr24       = PixelFormat(rawValue: SDL_PIXELFORMAT_BGR24.rawValue)
    static let rgb888      = PixelFormat(rawValue: SDL_PIXELFORMAT_RGB888.rawValue)
    static let rgbx8888    = PixelFormat(rawValue: SDL_PIXELFORMAT_RGBX8888.rawValue)
    static let bgr888      = PixelFormat(rawValue: SDL_PIXELFORMAT_BGR888.rawValue)
    static let bgrx8888    = PixelFormat(rawValue: SDL_PIXELFORMAT_BGRX8888.rawValue)
    static let argb8888    = PixelFormat(rawValue: SDL_PIXELFORMAT_ARGB8888.rawValue)
    static let rgba8888    = PixelFormat(rawValue: SDL_PIXELFORMAT_RGBA8888.rawValue)
    static let abgr888     = PixelFormat(rawValue: SDL_PIXELFORMAT_ABGR8888.rawValue)
    static let bgra8888    = PixelFormat(rawValue: SDL_PIXELFORMAT_BGRA8888.rawValue)
    static let argb2101010 = PixelFormat(rawValue: SDL_PIXELFORMAT_ARGB2101010.rawValue)
    static let rgba32      = PixelFormat(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_RGBA8888.rawValue : SDL_PIXELFORMAT_ABGR8888.rawValue))
    static let argb32      = PixelFormat(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_ARGB8888.rawValue : SDL_PIXELFORMAT_BGRA8888.rawValue))
    static let bgra32      = PixelFormat(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_BGRA8888.rawValue : SDL_PIXELFORMAT_ARGB8888.rawValue))
    static let abgr32      = PixelFormat(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_ABGR8888.rawValue : SDL_PIXELFORMAT_RGBA8888.rawValue))
    static let yv12        = PixelFormat(rawValue: SDL_PIXELFORMAT_YV12.rawValue)
    static let iyuv        = PixelFormat(rawValue: SDL_PIXELFORMAT_IYUV.rawValue)
    static let yuy2        = PixelFormat(rawValue: SDL_PIXELFORMAT_YUY2.rawValue)
    static let uyvy        = PixelFormat(rawValue: SDL_PIXELFORMAT_UYVY.rawValue)
    static let yvyu        = PixelFormat(rawValue: SDL_PIXELFORMAT_YVYU.rawValue)
    static let nv12        = PixelFormat(rawValue: SDL_PIXELFORMAT_NV12.rawValue)
    static let nv21        = PixelFormat(rawValue: SDL_PIXELFORMAT_NV21.rawValue)
    static let externalOes = PixelFormat(rawValue: SDL_PIXELFORMAT_EXTERNAL_OES.rawValue)

}