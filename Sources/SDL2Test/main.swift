import CSDL2


let SCREEN_WIDTH: Int32 = 1024
let SCREEN_HEIGHT: Int32 = 680

struct Size {
    let width: Int
    let height: Int
}

struct Rect {
    let size: Size
    let position: Point
    init(x: Int, y: Int, width: Int, height: Int) {
        self.size = Size(width: width, height: height)
        self.position = Point(x: x, y: y)
    }
}

extension Rect {
    var x: Int {
        return self.position.x
    }

    var y: Int {
        return self.position.y
    }

    var width: Int {
        return self.size.width
    }

    var height: Int {
        return self.size.height
    }
}

struct Point {
    let x: Int
    let y: Int
}

extension Point {
    static var zero: Point {
        return Point(x: 0, y: 0)
    }
}

enum WindowFlags: UInt32 {
    case fullscreen        = 0x00000001    /**< fullscreen window */
    case openGL            = 0x00000002    /**< window usable with OpenGL context */
    case shown             = 0x00000004    /**< window is visible */
    case hidden            = 0x00000008    /**< window is not visible */
    case borderless        = 0x00000010    /**< no window decoration */
    case resizeable        = 0x00000020    /**< window can be resized */
    case minimized         = 0x00000040    /**< window is minimized */
    case maximized         = 0x00000080    /**< window is maximized */
    case inputGrabbed      = 0x00000100    /**< window has grabbed input focus */
    case inputFocus        = 0x00000200    /**< window has input focus */
    case mouseFocus        = 0x00000400    /**< window has mouse focus */
    case fullscreenDesktop = 0x00001001    /**< SDL_WINDOW_FULLSCREEN | 0x00001000 */
    case foreign           = 0x00000800    /**< window not created by SDL */
    case allowHIDPI        = 0x00002000    /**< window should be created in high-DPI mode if supported.
                                                On macOS NSHighResolutionCapable must be set true in the
                                                application's Info.plist for this to have any effect. */
    case mouseCapture      = 0x00004000    /**< window has mouse captured (unrelated to INPUT_GRABBED) */
    case alwaysOnTop       = 0x00008000    /**< window should always be above others */
    case skipTaskbar       = 0x00010000    /**< window should not be added to the taskbar */
    case utility           = 0x00020000    /**< window should be treated as a utility window */
    case tooltip           = 0x00040000    /**< window should be treated as a tooltip */
    case popupMenu         = 0x00080000    /**< window should be treated as a popup menu */
    case vulkan            = 0x10000000    /**< window should us vulkan */
}

class Window {
    var _windowPtr: OpaquePointer?

    private func flagify(_ flags: [WindowFlags]) -> UInt32 {
        var result: Uint32 = 0
        flags.forEach { result = result | $0.rawValue }
        return result
    }

    init(title: String = "SDL Window", position pos: Point = .zero, size: Size, flags: [WindowFlags] = [.shown]) {
        print("Initializing window")
        _windowPtr = SDL_CreateWindow(title, Int32(pos.x), Int32(pos.y), Int32(size.width), Int32(size.height), flagify(flags)  )
    }

    deinit {
        self.destroy()
    }

    func update() {
        SDL_UpdateWindowSurface( _windowPtr );
    }

    func destroy() {
        print("Destroying Window")
        SDL_DestroyWindow(_windowPtr)
    }

    func getSurface() -> UnsafeMutablePointer<SDL_Surface> {
        return SDL_GetWindowSurface(_windowPtr)
    }

    func showMsg() {
        SDL_ShowSimpleMessageBox(UInt32(0), "test", "message", _windowPtr)

    }
}

class Renderer {
    var _rendererPtr: OpaquePointer?
    func render(_ renderClosure: (OpaquePointer?)->()) {
        renderClosure(_rendererPtr)
        SDL_RenderPresent(self._rendererPtr)
    }

    init(window: Window) {
        self._rendererPtr = SDL_CreateRenderer(window._windowPtr, -1, 0x00000002)
    }
}

extension Renderer {
    func setDrawColor(color: SDL_Color) {
        SDL_SetRenderDrawColor(self._rendererPtr, color.r, color.g, color.b, color.a)
    }
}

func drawRect(_ rect: Rect, surface: UnsafeMutablePointer<SDL_Surface>?, color: UInt32) {
    var _sdlRect = SDL_Rect(x: Int32(rect.x), y: Int32(rect.y), w: Int32(rect.width), h: Int32(rect.height))
    SDL_FillRect( surface, &_sdlRect, 0x00FF0000 );
}

func main() {
    let windowTest = Window(title: "Title", position: Point(x: 10, y: 10), size: Size(width: 200, height: 400)) 
    let screenSurface = windowTest.getSurface()
    let renderer = Renderer(window: windowTest)
    print(renderer)

    
    
    // drawRect(Rect(x: 10, y: 10, width: 30, height: 30), surface: screenSurface, color: 0x00FF0000)
    // windowTest.update()
    // windowTest.showMsg()
    var quit = false
    var event = SDL_Event()
    while !quit {
         while(SDL_PollEvent(&event) != 0) {
            switch event.type {
                case SDL_QUIT.rawValue:
                    quit = true
            default:
                print(event.type)
            }
        }
        
        renderer.render { ptr in
            SDL_SetRenderDrawColor(ptr, 0xFF, 0xFF, 0xFF, 0xFF)
            SDL_RenderClear( ptr );
            var rect = SDL_Rect(x: 10, y: 10, w: 20, h: 20)
            SDL_SetRenderDrawColor( ptr, 0xFF, 0x00, 0x00, 0xFF );		
            SDL_RenderFillRect(ptr, &rect)
        }
    }
   

    SDL_Quit()
    return 
}

main()