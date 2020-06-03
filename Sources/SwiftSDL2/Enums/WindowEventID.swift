
public enum WindowEventID: UInt8 {
    case none           /**< Never used */
    case shown          /**< Window has been shown */
    case hidden         /**< Window has been hidden */
    case exposed        /**< Window has been exposed and should be redrawn */
    case moved          /**< Window has been moved to data1, data2 */
    case resized        /**< Window has been resized to data1xdata2 */
    case sizeChanged    /**< The window size has changed, either as a result of an API call or through the ystem or user changing the window size. */
    case minimized      /**< Window has been minimized */
    case maximized      /**< Window has been maximized */
    case restored       /**< Window has been restored to normal size  and position */
    case enter          /**< Window has gained mouse focus */
    case leave          /**< Window has lost mouse focus */
    case focusGained    /**< Window has gained keyboard focus */
    case focusLost      /**< Window has lost keyboard focus */
    case closed         /**< The window manager requests that the window be closed */
    case takeFocus      /**< Window is being offered a focus (should SetWindowInputFocus() on itself or a subwindow, or ignore) */
    case hitTest        /**< Window had a hit test that wasn't SDL_HITTEST_NORMAL. */
} 
