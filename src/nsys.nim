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
  import ./nsys/glfw/callbacks as cb ; export cb
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
      res          : UVec2                   = uvec2(cfg.nsysWindowWidth, cfg.nsysWindowHeight);
      title        : str                     = cfg.nsysWindowTitle;
      resizable    : bool                    = cfg.nsysWindowResize;
      resize       : glfw.FrameBufferSizeFun = cb.resize;
      key          : glfw.KeyFun             = cb.key;
      mousePos     : glfw.CursorPosFun       = cb.mousePos;
      mouseBtn     : glfw.MouseButtonFun     = cb.mouseBtn;
      mouseScroll  : glfw.ScrollFun          = cb.mouseScroll;
      mouseCapture : bool                    = cfg.nsysMouseCapture;
      error        : glfw.ErrorFun           = cb.error;
    ) :System=
    result.win = Window.new(
      res          = res,
      title        = title,
      resizable    = resizable,
      resize       = resize,
      error        = error,
      ) # << Window.new( ... )
    result.inp = result.win.init(Input,
      key          = key,
      mousePos     = mousePos,
      mouseBtn     = mouseBtn,
      mouseScroll  = mouseScroll,
      mouseCapture = mouseCapture,
      ) # Assign cfg and Fill input with a dummy value
  #_____________________________
  proc init *(
      W            : Natural                 = cfg.nsysWindowWidth;
      H            : Natural                 = cfg.nsysWindowHeight;
      title        : str                     = cfg.nsysWindowTitle;
      resizable    : bool                    = cfg.nsysWindowResize;
      resize       : glfw.FrameBufferSizeFun = cb.resize;
      key          : glfw.KeyFun             = cb.key;
      mousePos     : glfw.CursorPosFun       = cb.mousePos;
      mouseBtn     : glfw.MouseButtonFun     = cb.mouseBtn;
      mouseScroll  : glfw.ScrollFun          = cb.mouseScroll;
      mouseCapture : bool                    = cfg.nsysMouseCapture;
      error        : glfw.ErrorFun           = cb.error;
    ) :System=
    result = nsys.init(
      res          = uvec2(W.uint32,H.uint32),
      title        = title,
      resizable    = resizable,
      resize       = resize,
      error        = error,
      key          = key,
      mousePos     = mousePos,
      mouseBtn     = mouseBtn,
      mouseScroll  = mouseScroll,
      mouseCapture = mouseCapture,
      ) # << System.new( ... )

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

