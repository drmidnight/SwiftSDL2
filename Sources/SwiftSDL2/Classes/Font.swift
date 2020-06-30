import CSDL2

//TODO: Add SDL_RWops support?
public struct FontStyle: OptionSet
{ 
    public let rawValue : Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let normal = FontStyle(rawValue: TTF_STYLE_NORMAL)
    public static let bold = FontStyle(rawValue: TTF_STYLE_BOLD)
    public static let italic = FontStyle(rawValue: TTF_STYLE_ITALIC)
    public static let underline = FontStyle(rawValue: TTF_STYLE_UNDERLINE)
    public static let strikethrough = FontStyle(rawValue: TTF_STYLE_STRIKETHROUGH)
}

public enum FontHinting: Int32 {
    case normal = 0 // TTF_HINTING_NORMAL
    case light = 1  // TTF_HINTING_LIGHT
    case mono = 2   // TTF_HINTING_MONO 
    case none = 3   // TTF_HINTING_NONE
}

public class Font {
    internal var _fontPtr: OpaquePointer?

    public convenience init(_ fileName: String, size: Int = 16) {
        self.init(fileName, size: size, index: 0)
    }

    public init(_ fileName: String, size: Int, index: Int) {
        if Self.wasInit() == false { Self.initialize() }
        self._fontPtr = TTF_OpenFontIndex(fileName, Int32(size), index)
    }

    deinit {
        self.close()
    }

    public func close() {
        print("Destroying Font")
        TTF_CloseFont(self._fontPtr)
    }

}

public extension Font {
    static var compileVersion: SDL.Version {
        return SDL.Version(major: Uint8(SDL_TTF_MAJOR_VERSION), minor:  Uint8(SDL_TTF_MINOR_VERSION), patch:  Uint8(SDL_TTF_PATCHLEVEL))
    }

    static var linkedVersion: SDL.Version? {
        guard let ver = TTF_Linked_Version() else { return nil }
        defer {
            ver.deallocate()
        }
        return SDL.Version(major: Uint8(ver.pointee.major), minor:  Uint8(ver.pointee.minor), patch:  Uint8(ver.pointee.patch))
    }

    static func byteSwappedUnicode(enabled: Bool) {
        TTF_ByteSwappedUNICODE(enabled ? 1 : 0) 
    }

    static func quit() {
        TTF_Quit()
    }

    // handle errors
    static func initialize() {
        TTF_Init()
    }

    static func wasInit() -> Bool {
        return TTF_WasInit() > 0
    }
}

public extension Font {
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

    var descent: Int {
        get {
            return Int(TTF_FontDescent(self._fontPtr))
        }
    }

    var height: Int {
        get {
            return Int(TTF_FontHeight(self._fontPtr))
        }
    }

    var lineSkip: Int {
        get {
            return Int(TTF_FontLineSkip(self._fontPtr))
        }
    }

    var faces: Int {
        get {
            return TTF_FontFaces(self._fontPtr)
        }
    }

    var isFixedWidth: Bool {
        get {
            return TTF_FontFaceIsFixedWidth(self._fontPtr) > 0 ? true : false
        }
    }

    var familyName: String {
        get {
            return String(cString:TTF_FontFaceFamilyName(self._fontPtr))
        }
    }

    var styleName: String {
        get {
            return String(cString:TTF_FontFaceStyleName(self._fontPtr))
        }
    }

    var kerningAllowed: Bool {
        get {
            return TTF_GetFontKerning(self._fontPtr) > 0 ? true : false
        }
        set {
            TTF_SetFontKerning(self._fontPtr, newValue ? 1 : 0)
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

    func renderText(_ text: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        switch type {
            case .solid:
                return Surface(TTF_RenderText_Solid(self._fontPtr, text, fgColor))
            case .shaded:
                return Surface(TTF_RenderText_Shaded(self._fontPtr, text, fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderText_Blended(self._fontPtr, text, fgColor))
        }
    }

    func renderUTF8(_ text: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        switch type {
            case .solid:
                return Surface(TTF_RenderUTF8_Solid(self._fontPtr, text, fgColor))
            case .shaded:
                return Surface(TTF_RenderUTF8_Shaded(self._fontPtr, text, fgColor, bgColor))
            case .blended:
               return Surface(TTF_RenderUTF8_Blended(self._fontPtr, text, fgColor))
        }
    }

    func renderUnicode(_ text: String, type: FontRenderType = .solid, fgColor: Color = .white, bgColor: Color = .black) -> Surface {
        // replace this with something better
        let u16StringPtr = text.uint16
        defer {
            u16StringPtr.deallocate()
        }
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

public extension Font {
    func getKerningSize(prevChar: Character, char: Character) throws -> Int {
        guard let charValue = char.asciiValue else { throw SDLError(message: "Bad character value")  }
        guard let prevCharValue = prevChar.asciiValue else { throw SDLError(message: "Bad character value")  }
        return Int(TTF_GetFontKerningSizeGlyphs(self._fontPtr, Uint16(prevCharValue), Uint16(charValue)))
    }

    func glyphProvided(_ char: Character) -> Bool {
        guard let char = char.asciiValue else { return false }
        return TTF_GlyphIsProvided(self._fontPtr, UInt16(char)) > 0
    }

    // throw?
    func glyphIndex(_ char: Character) -> Int {
        guard let char = char.asciiValue else { return -1 }
        return Int(TTF_GlyphIsProvided(self._fontPtr, UInt16(char)))
    }

    func size(of text: String) -> Size {
        var w: Int32 = 0
        var h: Int32 = 0
       
        guard TTF_SizeText(self._fontPtr, text, &w, &h) == 0 else { return .zero}
        
       return Size(width: w, height: h)
    }

    func sizeUTF8(of text: String) -> Size {
        var w: Int32 = 0
        var h: Int32 = 0
        
        guard TTF_SizeUTF8(self._fontPtr, text, &w, &h) == 0 else { return .zero}
        
        return Size(width: w, height: h)
    } 

    func sizeUnicode(of text: String) -> Size {
        var w: Int32 = 0
        var h: Int32 = 0
        let ptr = text.uint16
        defer {
            ptr.deallocate()
        }
 
        guard TTF_SizeUNICODE(self._fontPtr, ptr, &w, &h) == 0 else { return .zero}
        
        return Size(width: w, height: h)
    }

    struct GlyphMetrics {
        let minX: Int
        let maxX: Int 
        let minY: Int 
        let maxY: Int
        let advance: Int

        var width: Int {
            return self.maxX - self.minX
        }

        var height: Int {
            return self.maxY - self.minY
        } 
    }

    func glyphMetrics(for char: Character ) -> GlyphMetrics? {
        guard let char = char.asciiValue else { return nil }
        var minX: Int32 = 0
        var maxX: Int32 = 0
        var minY: Int32 = 0

        var maxY: Int32 = 0
        var advance: Int32 = 0
        guard TTF_GlyphMetrics(self._fontPtr, UInt16(char), &minX, &maxX, &minY, &maxY, &advance) == 0 else { return nil}

        return GlyphMetrics(minX: Int(minX), maxX: Int(maxX), minY: Int(minY), maxY: Int(maxY), advance: Int(advance))
    }
}