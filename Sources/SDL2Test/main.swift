import CSDL2

let SCREEN_WIDTH: Int32 = 1024
let SCREEN_HEIGHT: Int32 = 680

// move to surface class
// func drawRect(_ rect: Rect, surface: UnsafeMutablePointer<SDL_Surface>?, color: UInt32) {
//     var _sdlRect = SDL_Rect(x: Int32(rect.x), y: Int32(rect.y), w: Int32(rect.width), h: Int32(rect.height))
//     SDL_FillRect( surface, &_sdlRect, 0x00FF0000 );
// }

func main() {
    let windowTest = Window(title: "Title", position: Point(x: 10, y: 10), size: Size(width: 200, height: 400), flags: [.openGL]) 
    let screenSurface = windowTest.getSurface()
    let renderer = Renderer(window: windowTest)

    var quit = false
    var event = SDL_Event()

    while !quit {
        let start = SDL_GetPerformanceCounter()
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
            rndr?.drawColor = Color(r: 255, g: 255, b: 255, a: 255)
            rndr?.clear()

            let rect = Rect(x: 10, y: 10, width: 20, height: 20)
            rndr?.drawColor = Color(r: 255, g: 0, b: 0, a: 255)		
            rndr?.fillRect(rect)
        }

        // print(renderer.rendererInfo)

        let end = SDL_GetPerformanceCounter()
        let elapsed:Float = Float(end-start) / Float(SDL_GetPerformanceFrequency())
        // print("FPS: \(1.0/elapsed)")
    }
   

    SDL_Quit()
    return 
}

main()