#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# std dependencies
import std/strformat
# n*dk dependencies
import nstd/types as base
import nstd/address
from   nglfw      as glfw import nil
import nmath
# n*sys dependencies
import ../cfg
import ./types
import ./callbacks as cb


#_______________________________________
# Helpers
#__________________
func getSize *(w :var Window) :UVec2=
  ## Returns a Vector2 containing the most current window size.
  ## Also updates the stored value at `window.size`
  glfw.getWindowSize(w.ct, result.x.iaddr, result.y.iaddr)
  w.size = result


#_______________________________________
# Constructors
#__________________
proc new *(_:typedesc[Window]; 
    res          : UVec2                   = uvec2(cfg.nsysWindowWidth, cfg.nsysWindowHeight);
    title        : str                     = cfg.glfwWindowTitle;
    resizable    : bool                    = cfg.nsysWindowResize;
    resize       : glfw.FrameBufferSizeFun = cb.resize;
    error        : glfw.ErrorFun           = cb.error;
  ) :Window=
  ## Initializes and returns a new window with GLFW.
  discard glfw.setErrorCallback(error)
  doAssert glfw.init(), "Failed to Initialize GLFW"
  glfw.windowHint(glfw.CLIENT_API, glfw.NO_API)
  glfw.windowHint(glfw.Resizable, if resizable: glfw.True else: glfw.False)
  result.size  = res
  result.title = title
  result.ct    = glfw.createWindow(res.x.int32, res.y.int32, title.cstring, nil, nil)
  doAssert result.ct != nil, "Failed to create GLFW window"
  discard glfw.setFramebufferSizeCallback(result.ct, resize)  # Set viewport size/resize callback
#__________________
proc new *(_:typedesc[Window];
    W            : Natural                 = cfg.nsysWindowWidth;
    H            : Natural                 = cfg.nsysWindowHeight;
    title        : str                     = cfg.nsysWindowTitle;
    resizable    : bool                    = cfg.nsysWindowResize;
    resize       : glfw.FrameBufferSizeFun = cb.resize;
    error        : glfw.ErrorFun           = cb.error;
  ) :Window=
  ## Initializes the window with GLFW.
  result = Window.new(
    res          = uvec2(W,H),
    title        = title,
    resizable    = resizable,
    resize       = resize,
    error        = error,
    ) # << Window.new( ... )
#__________________
template init *(win :var Window;
    res          : UVec2                   = uvec2(cfg.nsysWindowWidth, cfg.nsysWindowHeight);
    title        : str                     = cfg.glfwWindowTitle;
    resizable    : bool                    = true;
    resize       : glfw.FrameBufferSizeFun = nil;
    key          : glfw.KeyFun             = nil;
    mousePos     : glfw.CursorPosFun       = nil;
    mouseBtn     : glfw.MouseButtonFun     = nil;
    mouseScroll  : glfw.ScrollFun          = nil;
    mouseCapture : bool                    = true;
    error        : glfw.ErrorFun           = error;
  ) :Window=
  ## Initializes and returns a new window with GLFW.
  ## Alias for win = Window.new( ... )
  win = Window.new(res, title, resizable, resize, key, mousePos, mouseBtn, mouseScroll, mouseCapture, error)
#__________________
proc close  *(win :Window) :bool=  glfw.windowShouldClose(win.ct)
  ## Returns true when the GLFW window has been marked to be closed.
proc term   *(win :Window) :void=  glfw.destroyWindow(win.ct); glfw.terminate()
  ## Terminates the GLFW window.
proc update *(win :Window) :void=  discard
  ## Updates the window. Needs to be called each frame.
  ## NOTE: Currently does nothing. Inputs all polled in the input.update() function instead.

