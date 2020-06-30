import CSDL2

public struct FontStyle: OptionSet
{
    
    public let rawValue : Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    static let normal = FontStyle(rawValue: TTF_STYLE_NORMAL)
    static let bold = FontStyle(rawValue: TTF_STYLE_BOLD)
    static let italic = FontStyle(rawValue: TTF_STYLE_ITALIC)
    static let underline = FontStyle(rawValue: TTF_STYLE_UNDERLINE)
    static let strikethrough = FontStyle(rawValue: TTF_STYLE_STRIKETHROUGH)

    static let all: FontStyle = [.normal, .bold, .italic, .underline, .strikethrough]
}

class Font {
    var _fontPtr: OpaquePointer?

    convenience init(_ fileName: String, size: Int = 16) {
        self.init(fileName, size: size, index: 0)
    }

    init(_ fileName: String, size: Int, index: Int) {
        self._fontPtr = TTF_OpenFontIndex(fileName, Int32(size), index)
    }

    deinit {
        self.close()
    }

    func close() {
        TTF_CloseFont(self._fontPtr)
    }

}

extension Font {
    var style: FontStyle {
        return  FontStyle(rawValue: TTF_GetFontStyle(self._fontPtr))
    }
}