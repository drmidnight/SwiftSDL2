import CSDL2


let SCREEN_WIDTH: Int32 = 1024
let SCREEN_HEIGHT: Int32 = 680



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

func drawRect(_ rect: Rect, surface: UnsafeMutablePointer<SDL_Surface>?, color: UInt32) {
    var _sdlRect = SDL_Rect(x: Int32(rect.x), y: Int32(rect.y), w: Int32(rect.width), h: Int32(rect.height))
    SDL_FillRect( surface, &_sdlRect, 0x00FF0000 );
}

func main() {
    let windowTest = Window(title: "Title", position: Point(x: 10, y: 10), size: Size(width: 200, height: 400), flags: [.openGL]) 
    let screenSurface = windowTest.getSurface()
    let renderer = Renderer(window: windowTest)

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
        
        // probably some retain issue. 
        // Fix this so it isnt a self reference. Maybe window.render() which passes in its renderer?
        renderer.render { rndr in
            rndr?.setDrawColor(Color(r: 0xFF, g: 0xFF, b: 0xFF, a: 0xFF))
            rndr?.clear()

            let rect = Rect(x: 10, y: 10, width: 20, height: 20)
            rndr?.setDrawColor(Color(r: 0xFF, g: 0x00, b: 0x00, a: 0xFF))		
            rndr?.fillRect(rect)
        }
    }
   

    SDL_Quit()
    return 
}

main()