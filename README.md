# SwiftSDL2

My attempt at wrapping SDL2. Heavily work-in-progress so don't use it. Hoping to have full coverage of SDL2 eventually.

*See [CSDL2](https://github.com/drmidnight/CSDL2) for bare C wrapper*
## Current progress:
### - Window
    ✔ SDL_CreateWindow 
    ✔ SDL_DestroyWindow
    ✔ SDL_UpdateWindowSurface 
    ✔ SDL_GetWindowSurface
    ✔ SDL_ShowSimpleMessageBox
### - Renderer
    ✔ SDL_CreateRenderer 
    ✔ SDL_DestroyRenderer 
    ✔ SDL_GetRenderDrawBlendMode
    ✔ SDL_GetRenderDrawColor
    ✔ SDL_GetRendererInfo
        ☐ Wrap with new RenderInfo type
    ✔ SDL_GetRendererOutputSize
    ✔ SDL_RenderClear
    ✔ SDL_RenderDrawLine
    ✔ SDL_RenderDrawLines
        ☐ add line width option
    ✔ SDL_RenderDrawPoint
    ✔ SDL_RenderDrawPoints
    ✔ SDL_RenderDrawRect
    ✔ SDL_RenderDrawRects
    ✔ SDL_RenderFillRect
    ✔ SDL_RenderFillRects
    ✔ SDL_RenderGetClipRect
    ✔ SDL_RenderGetIntegerScale
    ✔ SDL_RenderGetLogicalSize
    ✔ SDL_RenderSetLogicalSize
    ✔ SDL_RenderGetScale
    ✔ SDL_RenderGetViewport
    ✔ SDL_RenderIsClipEnabled
    ✔ SDL_RenderPresent
    ✔ SDL_RenderSetClipRect
    ✔ SDL_RenderSetIntegerScale
    ✔ SDL_RenderSetScale
    ✔ SDL_RenderSetViewport
    ✔ SDL_SetRenderDrawBlendMode
    ✔ SDL_SetRenderDrawColor
    ☐ SDL_RenderReadPixels
    ☐ SDL_RenderCopy

    # Needs SDL_Texture type
        ☐ SDL_RenderTargetSupported
        ☐ SDL_SetRenderTarget
        ☐ SDL_GetRenderTarget
        ☐ SDL_RenderCopyEx

    #Extra inits, backlog
    ☐ SDL_CreateSoftwareRenderer
    ☐ SDL_CreateWindowAndRenderer
### - Texture
    ✔ SDL_CreateTexture 
    ✔ SDL_CreateTextureFromSurface
    ✔ SDL_DestroyTexture
    ✔ SDL_GetTextureAlphaMod
    ✔ SDL_GetTextureBlendMode
    ✔ SDL_GetTextureColorMod
    ✔ SDL_LockTexture 
    ✔ SDL_QueryTexture
    ✔ SDL_RenderCopy 
    ✔ SDL_SetTextureAlphaMod
    ✔ SDL_SetTextureBlendMode
    ✔ SDL_SetTextureColorMod
    ✔ SDL_UnlockTexture
    ☐ SDL_UpdateTexture
### - Misc
    ☐ Handle SDL_Error everywhere
    ☐ Profile for leaks due to OpaquePointer usage