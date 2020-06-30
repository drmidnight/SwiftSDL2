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
}

enum FontHinting: Int32 {
    case normal = 0 // TTF_HINTING_NORMAL
    case light = 1  // TTF_HINTING_LIGHT
    case mono = 2   // TTF_HINTING_MONO 
    case none = 3   // TTF_HINTING_NONE
}

public class Font {
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
        get {
            return FontStyle(rawValue: TTF_GetFontStyle(self._fontPtr)) 
        }
        set {
            TTF_SetFontStyle(self._fontPtr, newValue.rawValue)
        }
    }

     var outline: Int {
        get {
             return  Int(TTF_GetFontOutline(self._fontPtr))
        }
        set {
            TTF_SetFontOutline(self._fontPtr, Int32(newValue))
        }
    }

     var hinting: FontHinting {
        get {
            guard let hinting = FontHinting(rawValue: TTF_GetFontHinting(self._fontPtr)) else { return .none }
            return hinting
        }
        set {
            TTF_SetFontHinting(self._fontPtr, newValue.rawValue)
        }
    }

    var ascent: Int {
        get {
            return Int(TTF_FontAscent(self._fontPtr))
        }
    }

    var height: Int {
        get {
            return Int(TTF_FontHeight(self._fontPtr))
        }
    }
}

public enum FontRenderType {
    case solid
    case shaded
    case blended
}

public extension Font {
    func renderGlyph(_ char: Character, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) throws -> Surface {
        guard let charValue = char.asciiValue else { throw SDLError(message: "Bad character value")  }
        switch type {
            case .solid:
                return Surface(TTF_RenderGlyph_Solid(self._fontPtr, UInt16(charValue), fgColor))
            case .shaded:
                return Surface(TTF_RenderGlyph_Shaded(self._fontPtr, UInt16(charValue), fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderGlyph_Blended(self._fontPtr, UInt16(charValue), fgColor))
        }
    }

    func renderText(_ string: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        switch type {
            case .solid:
                return Surface(TTF_RenderText_Solid(self._fontPtr, string, fgColor))
            case .shaded:
                return Surface(TTF_RenderText_Shaded(self._fontPtr, string, fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderText_Blended(self._fontPtr, string, fgColor))
        }
    }

    func renderUTF8(_ string: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        switch type {
            case .solid:
                return Surface(TTF_RenderUTF8_Solid(self._fontPtr, string, fgColor))
            case .shaded:
                return Surface(TTF_RenderUTF8_Shaded(self._fontPtr, string, fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderUTF8_Blended(self._fontPtr, string, fgColor))
        }
    }

    func renderUnicode(_ string: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        // replace this with something better
        let u16StringPtr = UnsafeMutablePointer<UInt16>.allocate(capacity: string.utf16.count + 1) 
        var len = 0
        for code in string.utf16 {
            u16StringPtr[len] = code
            len += 1
        }
        u16StringPtr[len] = 0

        switch type {
            case .solid:
                return Surface(TTF_RenderUNICODE_Solid(self._fontPtr, u16StringPtr, fgColor))
            case .shaded:
                return Surface(TTF_RenderUNICODE_Shaded(self._fontPtr, u16StringPtr, fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderUNICODE_Blended(self._fontPtr, u16StringPtr, fgColor))
        }
    }
}