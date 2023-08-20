# n*sys | System-specific Interaction tools
Thin GLFW interop library.  
Returns a `System` object, that contains a Window object and a dummy input Handle.  
Populates the input callbacks with some sane defaults when they are omitted.  

**Notes**:
Most things are done with glfw, instead of manually through the system APIs.  
This library avoids having to create duplicates for `window.nim` and `input.nim` in every renderer API module with the exact same functionality.  

## How to
Simple API
```nim
import nsys

# Minimal API
var sys = nsys.init(960,540)  # Open window and input, and return a System object
while not sys.close():        # While the system.window has not been marked for closing
  sys.update()                # Update the window and input
sys.term()                    # Terminate the data when we are done

# The nsys.init() function can be called with just a size, due to all arguments having sane defaults.
# See the nsys.nim file for other versions of the `init()` constructor, and all their possible inputs.
```

**Compile-time configuration switches**:
```md
# API support
Supports wgpu-native and Vulkan by default.  (Opens a window with glfw.NoAPI)
- [ ] TODO:  OpenGL support

# Formatting
-d:glfwPrefix:newPrefix      default -> "n*GLFW"
-d:glfwWindowTitle:newTitle  default -> glfwPrefix&" | Window"
-d:nsysPrefix:newPrefix      default -> "「nsys」"
-d:nsysWindowTitle:newTitle  default -> nsysPrefix&" | Window"

# Backend
_Note: These are currently not useful. Stored here for documentation completeness._
-d:nsysGLFW   : (default) Marks the library for working with GLFW. Overrides `nsysNative`
-d:nsysNative : Marks the library for working with the native system (not implemented)
```
