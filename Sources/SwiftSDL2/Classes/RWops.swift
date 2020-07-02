import CSDL2
// TODO: Change this. While I feel like the "r" "w+" etc chars should be sufficient I think a more "swift" style would be an enum
// needs better naming though. Maybe make these composable? [.read, .write] instead of .readWrite ? could be an OptionSet...
// enum RWopsMode {
//     case read
//     case write
//     case append
//     case binary
// }

// extension RWopsMode {
//     var modeString: String {
//         switch self {
//             case .read: return "r"
//             case .append: return "a"
//             case .write: return "w"
//             case .binary: return "b"
//         }
//     }
// }

class RWops {
    internal var _rwPointer: UnsafeMutablePointer<SDL_RWops>?

    init(from file: String, mode: String) throws {
        self._rwPointer = try wrapPtr {
            SDL_RWFromFile(file, mode)
        }
    }

    // TODO: make this generic?
    public func write(_ text: String) {
        var dataPtr = Array(text.utf8)
        SDL_RWwrite(self._rwPointer, &dataPtr, 1, dataPtr.count)
    }

    // TODO: make this actually work. Currently asserts due to "free(): invalid size" 
    public func read(count: Int) -> [Int8]  {
        print("entered")
        let rwSize = SDL_RWsize(self._rwPointer)
        var data = UnsafeMutablePointer<Int8>.allocate(capacity: count + 1)
        defer {
            self.close()
            data.deallocate()
        }
        var totalRead = 0
        var read = 1
        while totalRead < rwSize && read != 0 {
            read = SDL_RWread(self._rwPointer, data, 1, Int(rwSize) - totalRead)
            print(read)
            totalRead += read
        }

        let typed = UnsafeMutableBufferPointer(start: data, count: count + 1)
        return Array(typed)
    }

    public func close() {
        SDL_RWclose(self._rwPointer)
    }
}