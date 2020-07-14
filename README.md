# SwiftSDL2

Swift 5.2+ wrapper for SDL2.
## DISCLAIMER
Heavily work-in-progress, so use at your own risk. Things will change and evolve as I tackle more of SDL2. 

*See [CSDL2](https://github.com/drmidnight/CSDL2) for bare C wrapper*

## Current Requirements:
*_tested on Ubuntu 20.04 LTS and Mac OS 10.15.5_
#### Linux
- [SDL2](https://www.libsdl.org) (2.0.10)
- [SDL_image](https://www.libsdl.org/projects/SDL_image/) (2.0.5)
- [SDL_ttf](https://www.libsdl.org/projects/SDL_ttf/)  (2.0.15)

#### Mac
- ``` brew install sdl2 sdl2_image sdl2_ttf ```

> If you are having issues with headers not found see [CSDL2 > shim.h](https://github.com/drmidnight/CSDL2/blob/master/shim.h) for paths.

## Current progress:
#### SDL2:
Core functionality is there (Window, Renderer, Texture, Surface, Events)

#### SDL_ttf:
API has nearly full coverage. I left out RW functions that need _SDL_RWops_ wrapped. Also needs proper error handling.

#### SDL_image
Same as _SDL_ttf_, needs _SDL_RWops_ wrapped. 
Which in the case of _SDL_image_ is most of the functions, however you can create a Surface from an image file which covers 90% of the usage.

## Example:
*See [SwiftSDL2Example](https://github.com/drmidnight/SwiftSDL2Example)*

## License
[MIT](https://choosealicense.com/licenses/mit/)
