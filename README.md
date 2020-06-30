# SwiftSDL2

Swift wrapper for SDL2.

Heavily work-in-progress, so use at your own risk. Things will change and evolve as I tackle more of SDL2. I'm hoping to have the core and all additions (image, ttf, mixer, net) fully wrapped eventually. 

*See [CSDL2](https://github.com/drmidnight/CSDL2) for bare C wrapper*

## Current Requirements:

- [SDL2](https://www.libsdl.org) (2.0.10>)
- [SDL_image](https://www.libsdl.org/projects/SDL_image/) (2.0.5)
- [SDL_ttf](https://www.libsdl.org/projects/SDL_ttf/)  (2.0.15)

## Current progress:
#### SDL2:
Core functionality is there (Window, Renderer, Texture, Surface, Events)

#### SDL_ttf:
API has nearly full coverage. I left out RW functions that need _SDL_RWops_ wrapped. Also needs proper error handling.

#### SDL_image
Same as _SDL_ttf_, needs _SDL_RWops_ wrapped. 
Which in the case of _SDL_image_ is most of the functions, however you can create a Surface from an image file which covers 90% of the usage.

## Quick Example:
Subject to change, but here is a simple usage example that opens a window and draws a red square:
```Swift
import SwiftSDL2

SDL.initialize([.video])
SDL.initialize(imageSupport: [.png])

class SDLExample {
    var renderer: Renderer
    let window: Window

    init(_ title: String = "SDL2") {
        self.window = Window(title: title, position: Point(x: 10, y: 10), size: Size(width: 1024, height: 789), flags: [.openGL, .resizeable])
        self.renderer = Renderer(window: self.window, flags: [.vsync])
    }

    func render(_ closure: (Renderer)-> Void) {
        self.renderer.clear()
        closure(self.renderer)
        self.renderer.present()
    }

    func main(_ closure: () ->()) {
        defer{ 
            SDL.quit()
            Font.quit()
        }
        closure()  
    }
}

let example = SDLExample("SDL2 Example")

example.main {
    let imageTexture = Texture(renderer: example.renderer, image: "image.jpeg")

    let font = Font( "fontFile.ttf", size: 16 )
    let fontTextTest = font.renderText("Hello, world!")
    let fontTextTestTexture = Texture(renderer: example.renderer, surface: fontTextTest)
    var quit = false 

    while !quit {
        // event polling
        SDL.pollEvents { event in
            switch event.kind {
                case .keyDown:
                    if event.isModDown(.leftCtrl) {
                        if event.isPressed(.Z) {
                           
                        }
                    }

                   if event.isPressed(.backspace, repeats: true) {
                       print("Backspace is held down")
                    }

                    if event.isPressed(.escape) {
                        quit = true
                    }

                case .window: 
                    print("Window Event: \(event.window.eventID)")

                case .mouseBtnDown:
                    if event.clicked(mouseBtn: .left, clicks: 2) {
                        print("Mouse Clicked twice")
                    }

                case .quit: 
                    quit = true

                case .textInput:
                    //TODO: make text input cleaner
                    let keyCode = event.text.text.0 
                    if let scalar = UnicodeScalar(Int(keyCode)) {
                        let char = Character(scalar)
                            print(char)
                    }
                           
                default:
                    if let eventKind = event.kind {
                        print("Event not handled: \(eventKind)")
                    }   
            }
        }

        example.render { renderer in
            renderer.drawColor = .red
            renderer.fillRect(Rect(x: 10, y: 10, w: 200, h: 200))
            // Hex color support
            renderer.drawColor = Color(hex: 0x1a1726)

            renderer.renderCopy(texture: fontTextTestTexture)
            renderer.renderCopy(texture: imageTexture)
        }
    }
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)