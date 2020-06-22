import CSDL2

public enum MessageBoxFlags: UInt32{
    case error   = 0x00000010  /** SDL_MESSAGEBOX_ERROR < error dialog */
    case warning = 0x00000020  /** SDL_MESSAGEBOX_WARNING < warning dialog */
    case info    = 0x00000040  /** SDL_MESSAGEBOX_INFORMATION < informational dialog */
}