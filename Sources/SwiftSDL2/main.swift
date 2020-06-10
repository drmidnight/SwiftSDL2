import CSDL2


// import Foundation
// @discardableResult
// func shell(_ args: String...) -> Int32 {
//     let task = Process()
//     task.executableURL = "/usr/bin/env"
//     task.arguments = args
//     task.run()
//     task.waitUntilExit()
//     return task.terminationStatus
// }

class Game {
    var renderer: Renderer
    let window: Window

    init(_ title: String = "SDL2 - Swift") {
        self.window = Window(title: title, position: Point(x: 10, y: 10), size: Size(width: SCREEN_WIDTH, height: SCREEN_HEIGHT), flags: [.openGL])
        self.renderer = Renderer(window: self.window)
    }

    func render(_ closure: (Renderer)-> Void) {
        closure(self.renderer)
        self.renderer.present()
    }

}
let SCREEN_WIDTH: Int32 = 1024
let SCREEN_HEIGHT: Int32 = 680

// initialize subsystems
SDL.initialize([.video])
SDL.initialize(imageSupport: [.png])
// playground. write some tests.
SDL.main {
    print(SDL.version)
    TTF_Init()

   

    //let surface = Surface(from:"/home/derp/Developer/Swift/SDL2Test/Sources/SwiftSDL2/sdl.jpeg" )
    let game = Game("Game test")

    let scale: Int = 2
    game.renderer.scale = Vector2(x: Float(scale), y: Float(scale))
    let tex = Texture(renderer: game.renderer, image: "/home/derp/Developer/Swift/SDL2Test/Sources/SwiftSDL2/sdl.jpeg")

    var quit = false
   
    let points = [
        Point(x: 10, y: 10),
        Point(x: 20, y: 20),
        Point(x: 30, y: 30),
        Point(x: 40, y: 10),
        Point(x: 50, y: 40),
        Point(x: 60, y: 10)
    ]

    let font = TTF_OpenFont( "/home/derp/Developer/Swift/SDL2Test/Sources/SwiftSDL2/monogram.ttf", 16 );
    let surfacePtr = TTF_RenderText_Solid(font, "WE HAVE FONTS", Color.black)
    let surfaceText = Surface(surfacePtr) 
    let textTexture = Texture(renderer: game.renderer, surface: surfaceText)
    let textureSize = textTexture.info.size
    let scaledX =  (SCREEN_WIDTH / Int32(2*scale))
    let fontRect = Rect(x:scaledX - (Int32(textureSize.width) / 2), y: 10, w: Int32(textureSize.width), h: Int32(textureSize.height))
    print(fontRect)
    defer {
        TTF_CloseFont(font)
        TTF_Quit()
    }

    
    // figure out best way to handle texture updating
    // var bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 4)
    // bytesPointer.storeBytes(of: 255, as: UInt32.self)
    // // hmm think of a way to handle texture updates internal to the class.
    // var pixels = [UInt32](repeating: 0, count: 200 * 400)
    // var surfacePixels = surface._surfacePtr?.pointee.pixels
    // var value: UInt32 = 255
    // memcpy(&pixels, bytesPointer, 200 * 400 * MemoryLayout<UInt32>.size)
    // print(pixels)

    


    let format = tex.query().format
    switch format {
        case .rgb888:
            print("RGB8 \(format)")
        default:
            print(format)
    }
    print(EventType.keyUp.rawValue)
    while !quit {
        let start = SDL_GetPerformanceCounter()

        SDL.pollEvents { event in
            switch event.kind {
                case .keyDown:
                    if event.isPressed(.escape) {
                        quit = true
                    }
                case .window: print(event.window.eventID)
                case .quit: quit = true
                default:
                    if let eventKind = event.kind {
                        print("Event not handled: \(eventKind)")
                    }
                   
            }
        }
           
        game.renderer.drawColor = Color(r: 0, g: 0, b: 0, a: 255)
        game.renderer.clear()
        game.renderer.renderCopy(texture: tex)
        game.renderer.renderCopy(texture: textTexture, dstRect: fontRect)


        game.render { rndr in
            rndr.drawColor = Color(hex: 0x005DAA)
            // rndr?.clear()

            let rect = Rect(x: 10, y: 10, w: 20, h: 20)
            rndr.drawColor = Color(r: 255, g: 0, b: 0, a: 255)
            rndr.fillRect(rect)
            rndr.drawLines(points: points, color: Color.red)
        }
        // print(renderer.rendererInfo)
        game.renderer.present()
        let end = SDL_GetPerformanceCounter()
        let elapsed:Double = Double(end-start) / Double(SDL_GetPerformanceFrequency()) * 1000
        
        SDL_Delay(UInt32(floor(max(0,16.666 - elapsed))))

    }
    SDL.printError()

}

