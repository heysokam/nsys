> **Warning**:  
> _This library is in **Low Maintainance** mode._  
> _See the [relevant section](#low-maintainance-mode) for an explanation of what that means._  

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

# The nsys.init() function can be called without any inputs. All arguments have sane defaults.
# See the nsys.nim file for other versions of the `init()` constructor, and all their possible inputs.
```

**Compile-time configuration switches**:
```md
# API support
Supports wgpu-native and Vulkan by default.  (Opens a window with glfw.NoAPI)
- [ ] TODO:  OpenGL support

# Formatting
-d:glfwPrefix:newPrefix      : default -> "n*GLFW"
-d:glfwWindowTitle:newTitle  : default -> glfwPrefix&" | Window"
-d:nsysPrefix:newPrefix      : default -> "「nsys」"
-d:nsysWindowTitle:newTitle  : default -> nsysPrefix&" | Window"

# Other Config
-d:nsysWindowWidth:N       : default -> 960
-d:nsysWindowHeight:N      : default -> 540
-d:nsysWindowResize:on/off : default -> off
-d:nsysMouseCapture:on/off : default -> off

# Backend
_Note: These are currently not useful. Stored here for documentation completeness._
-d:nsysGLFW   : (default) Marks the library for working with GLFW. Overrides `nsysNative`
-d:nsysNative : (not implemented) Marks the library for working with the native system
```

## Low Maintainance mode
This library is in low maintainance mode.  

New updates are unlikely to be implemented, unless:
- They are randomnly needed for some casual side project _(eg: a gamejam or similar)_  
- They are submitted through a PR  

Proposals and PRs are very welcomed, and will likely be accepted.  

> See the [relevant section](#why-i-changed-pure-nim-to-be-my-auxiliary-programming-language-instead-of-being-my-primary-focus) for an explaination of why this is the case.

---

### Why I changed Pure Nim to be my auxiliary programming language, instead of being my primary focus
> _Important:_  
> _This reason is very personal, and it is exclusively about using Nim in a manual-memory-management context._  
> _Nim is great as it is, and the GC performance is so optimized that it's barely noticeable that it is there._  
> _That's why I still think Nim is the best language for projects where a GC'ed workflow makes more sense._  

Nim with `--mm:none` was always my ideal language.  
But its clear that the GC:none feature (albeit niche) is only provided as a sidekick, and not really maintained as a core feature.  

I tried to get Nim to behave correctly with `--mm:none` for months and months.  
It takes an absurd amount of unnecessary effort to get it to a basic default state.  

And I'm not talking about the lack of GC removing half of the nim/std library because of nim's extensive use of seq/string in its stdlib.  
I'm talking about features that shouldn't even be allowed to exist at all in a gc:none context, because they leak memory and create untrackable bugs.  
_(eg: exceptions, object variants, dynamically allocated types, etc etc)_  

After all of that effort, and seeing how futile it was, I gave up on `--mm:none` completely.  
It would take a big amount of effort patching nim itself so that these issues are no longer there.  
And, sadly, based on experience, I'm not confident in my ability to communicate with Nim's leadership to do such work myself.  

This setback led me to consider other alternatives, including Zig or Pure C.  
But, in the end, I decided that from now on I will be programming with my [MinC](https://github.com/heysokam/minc) source-to-source language/compiler instead.  

As such, I will be deprecating most of my `n*dk` libraries.  
I will be creating my engine's devkit with MinC instead.  

That means, as it is detailed in the [Low Maintainance](#low-maintainance-mode) section, that this library will receive a very low/minimal amount of support.

