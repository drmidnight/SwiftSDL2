import CSDL2

// maybe think about making these all uppercase?
public struct PixelFormats: OptionSet
{
    
    public let rawValue : UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let   unknown     = PixelFormats(rawValue: SDL_PIXELFORMAT_UNKNOWN.rawValue)
    public static let  index1lsb   = PixelFormats(rawValue: SDL_PIXELFORMAT_INDEX1LSB.rawValue)
    public static let  index1msb   = PixelFormats(rawValue: SDL_PIXELFORMAT_INDEX1MSB.rawValue)
    public static let  index4lsb   = PixelFormats(rawValue: SDL_PIXELFORMAT_INDEX4LSB.rawValue)
    public static let  index4msb   = PixelFormats(rawValue: SDL_PIXELFORMAT_INDEX4MSB.rawValue)
    public static let  index8      = PixelFormats(rawValue: SDL_PIXELFORMAT_INDEX8.rawValue)
    public static let  rgb332      = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB332.rawValue)
    public static let  rgb444      = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB444.rawValue)
    public static let  rgb555      = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB555.rawValue)
    public static let  bgr555      = PixelFormats(rawValue: SDL_PIXELFORMAT_BGR555.rawValue)
    public static let  argb4444    = PixelFormats(rawValue: SDL_PIXELFORMAT_ARGB4444.rawValue)
    public static let  rgba4444    = PixelFormats(rawValue: SDL_PIXELFORMAT_RGBA4444.rawValue)
    public static let  abgr4444    = PixelFormats(rawValue: SDL_PIXELFORMAT_ABGR4444.rawValue)
    public static let  bgra4444    = PixelFormats(rawValue: SDL_PIXELFORMAT_BGRA4444.rawValue)
    public static let  argb1555    = PixelFormats(rawValue: SDL_PIXELFORMAT_ARGB1555.rawValue)
    public static let  rgba555     = PixelFormats(rawValue: SDL_PIXELFORMAT_RGBA5551.rawValue)
    public static let  abgr1555    = PixelFormats(rawValue: SDL_PIXELFORMAT_ABGR1555.rawValue)
    public static let  bgra5551    = PixelFormats(rawValue: SDL_PIXELFORMAT_BGRA5551.rawValue)
    public static let  rgb565      = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB565.rawValue)
    public static let  bgr565      = PixelFormats(rawValue: SDL_PIXELFORMAT_BGR565.rawValue)
    public static let  rgb24       = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB24.rawValue)
    public static let  bgr24       = PixelFormats(rawValue: SDL_PIXELFORMAT_BGR24.rawValue)
    public static let  rgb888      = PixelFormats(rawValue: SDL_PIXELFORMAT_RGB888.rawValue)
    public static let  rgbx8888    = PixelFormats(rawValue: SDL_PIXELFORMAT_RGBX8888.rawValue)
    public static let  bgr888      = PixelFormats(rawValue: SDL_PIXELFORMAT_BGR888.rawValue)
    public static let  bgrx8888    = PixelFormats(rawValue: SDL_PIXELFORMAT_BGRX8888.rawValue)
    public static let  argb8888    = PixelFormats(rawValue: SDL_PIXELFORMAT_ARGB8888.rawValue)
    public static let  rgba8888    = PixelFormats(rawValue: SDL_PIXELFORMAT_RGBA8888.rawValue)
    public static let  abgr888     = PixelFormats(rawValue: SDL_PIXELFORMAT_ABGR8888.rawValue)
    public static let  bgra8888    = PixelFormats(rawValue: SDL_PIXELFORMAT_BGRA8888.rawValue)
    public static let  argb2101010 = PixelFormats(rawValue: SDL_PIXELFORMAT_ARGB2101010.rawValue)
    public static let  rgba32      = PixelFormats(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_RGBA8888.rawValue : SDL_PIXELFORMAT_ABGR8888.rawValue) )
    public static let  argb32      = PixelFormats(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_ARGB8888.rawValue : SDL_PIXELFORMAT_BGRA8888.rawValue) )
    public static let  bgra32      = PixelFormats(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_BGRA8888.rawValue : SDL_PIXELFORMAT_ARGB8888.rawValue) )
    public static let  abgr32      = PixelFormats(rawValue: ( SDL_BYTEORDER == SDL_BIG_ENDIAN ? SDL_PIXELFORMAT_ABGR8888.rawValue : SDL_PIXELFORMAT_RGBA8888.rawValue) )
    public static let  yv12        = PixelFormats(rawValue: SDL_PIXELFORMAT_YV12.rawValue)
    public static let  iyuv        = PixelFormats(rawValue: SDL_PIXELFORMAT_IYUV.rawValue)
    public static let  yuy2        = PixelFormats(rawValue: SDL_PIXELFORMAT_YUY2.rawValue)
    public static let  uyvy        = PixelFormats(rawValue: SDL_PIXELFORMAT_UYVY.rawValue)
    public static let  yvyu        = PixelFormats(rawValue: SDL_PIXELFORMAT_YVYU.rawValue)
    public static let  nv12        = PixelFormats(rawValue: SDL_PIXELFORMAT_NV12.rawValue)
    public static let  nv21        = PixelFormats(rawValue: SDL_PIXELFORMAT_NV21.rawValue)
    public static let  externalOes = PixelFormats(rawValue: SDL_PIXELFORMAT_EXTERNAL_OES.rawValue)

}