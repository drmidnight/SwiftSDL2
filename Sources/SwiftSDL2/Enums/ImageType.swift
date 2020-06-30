import CSDL2

public struct ImageType: OptionSet {
    public let rawValue : Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    public static let jpg = ImageType(rawValue: Int32(IMG_INIT_JPG.rawValue))
    public static let png = ImageType(rawValue: Int32(IMG_INIT_PNG.rawValue))
    public static let tif = ImageType(rawValue: Int32(IMG_INIT_TIF.rawValue))
    public static let webp = ImageType(rawValue: Int32(IMG_INIT_WEBP.rawValue))
}