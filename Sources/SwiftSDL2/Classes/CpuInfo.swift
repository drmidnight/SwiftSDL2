
import CSDL2

public struct CpuInfo {
    @available(*, unavailable) private init() {}

    static public var cpuCount: Int {
        return Int(SDL_GetCPUCount())
    }

    static public var cacheLineSize: Int {
        return Int(SDL_GetCPUCacheLineSize())
    }

    static public var hasRDTSC: Bool {
        return SDL_HasRDTSC().toBool
    }

    static public var hasAltiVec: Bool {
        return SDL_HasAltiVec().toBool
    }

    static public var hasMMX: Bool{
        return SDL_HasMMX().toBool
    }

    static public var has3DNow: Bool{
        return SDL_Has3DNow().toBool
    }

    static public var hasSSE: Bool{
        return SDL_HasSSE().toBool
    }

    static public var hasSSE2: Bool{
        return SDL_HasSSE2().toBool
    }

    static public var hasSSE3: Bool{
        return SDL_HasSSE3().toBool
    }

    static public var hasSSE41: Bool{
        return SDL_HasSSE41().toBool
    }

    static public var hasSSE42: Bool{
        return SDL_HasSSE42().toBool
    }

    static public var hasAVX: Bool{
        return SDL_HasAVX().toBool
    }

    static public var hasAVX2: Bool{
        return SDL_HasAVX2().toBool
    }

    static public var hasAVX512F: Bool{
        return SDL_HasAVX512F().toBool
    }

    static public var hasNeon: Bool{
        return SDL_HasNEON().toBool
    }

    static public var systemRAM: Int {
        return Int(SDL_GetSystemRAM())
    }

    static public var simdAlignment: Int {
        return SDL_SIMDGetAlignment()
    }

    static public func simdAlloc(size: Int) -> UnsafeMutableRawPointer {
        return SDL_SIMDAlloc(size)
    }

    static public func simdFree(ptr: UnsafeMutableRawPointer) {
        return SDL_SIMDFree(ptr)
    }
}