#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# n*dk dependencies
import nstd/types as base
import nmath
from   nglfw as glfw import nil
# n*sys dependencies
import ./nsys/backend
# Backend-specific dependencies
when backend.GLFW:
  # Use the `nglfw` wrapper by default
  import ./nsys/glfw/window ; export window
  import ./nsys/glfw/input  ; export input
  import ./nsys/glfw/types  ; export types
else: # Native dependencies
  {.error: "n*sys -> Native support is currently not implemented.".}
# Backend-agnostic import/exports
import ./nsys/tools ; export tools
import ./nsys/cfg   ; export cfg


#_____________________________
# Backend-agnostic types
type System * = object
  win  *:Window
  inp  *:Input


#_____________________________
# GLFW-specific behavior
when backend.GLFW:
  #_____________________________
  # Constructor
  proc init *(
      W,H          : Natural;
      title        : str                     = cfg.nsysWindowTitle;
      resizable    : bool                    = false;
      resize       : glfw.FrameBufferSizeFun = window.resize;
      key          : glfw.KeyFun             = input.key;
      mousePos     : glfw.CursorPosFun       = input.mousePos;
      mouseBtn     : glfw.MouseButtonFun     = input.mouseBtn;
      mouseScroll  : glfw.ScrollFun          = input.mouseScroll;
      mouseCapture : bool                    = true;
      error        : glfw.ErrorFun           = window.error;
    ) :System=
    result.win = Window.new(
      res          = uvec2(W.uint32,H.uint32),
      title        = title,
      resizable    = resizable,
      resize       = resize,
      key          = key,
      mousePos     = mousePos,
      mouseBtn     = mouseBtn,
      mouseScroll  = mouseScroll,
      mouseCapture = mouseCapture,
      error        = error,
      ) # << Window.new( ... )
    result.inp = 0.Input # Fill input with a dummy value
  #_____________________________
  proc init *(
      res          : UVec2;
      title        : str                     = cfg.nsysWindowTitle;
      resizable    : bool                    = false;
      resize       : glfw.FrameBufferSizeFun = window.resize;
      key          : glfw.KeyFun             = input.key;
      mousePos     : glfw.CursorPosFun       = input.mousePos;
      mouseBtn     : glfw.MouseButtonFun     = input.mouseBtn;
      mouseScroll  : glfw.ScrollFun          = input.mouseScroll;
      mouseCapture : bool                    = true;
      error        : glfw.ErrorFun           = window.error;
    ) :System=
    result.win = Window.new(
      res          = res,
      title        = title,
      resizable    = resizable,
      resize       = resize,
      key          = key,
      mousePos     = mousePos,
      mouseBtn     = mouseBtn,
      mouseScroll  = mouseScroll,
      mouseCapture = mouseCapture,
      error        = error,
      ) # << Window.new( ... )
    result.inp = 0.Input # Fill input with a dummy value
  #_____________________________
  # Behavior
  proc close  *(sys :System) :bool=  glfw.windowShouldClose(sys.win.ct)
    ## Returns true when the GLFW window has been marked to be closed.
  proc term   *(sys :System) :void=  glfw.destroyWindow(sys.win.ct); glfw.terminate()
    ## Terminates the GLFW window.
  proc update *(sys :System) :void=  sys.inp.update(); sys.win.update()
    ## Updates the input and window. Needs to be called each frame.
else: # Native dependencies
  {.error: "n*sys -> Native support is currently not implemented.".}



#_______________________________________
# Debug : Entry Point example
when isMainModule:
  # import ./nsys
  echo nsysPrefix&"Hello Window with Input!"
  var sys = nsys.init(960,540)
  while not sys.close(): sys.update()
  sys.term()

