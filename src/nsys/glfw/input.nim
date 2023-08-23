#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# External dependencies
from nglfw as glfw import nil
# n*sys dependencies
import ./types
import ./callbacks as cb
import ../cfg


#_____________________________
proc update *(inp :Input) :void=  glfw.pollEvents()
  ## Orders GLFW to search for input events that happened this frame.

#_____________________________
proc init *(
    win          : Window;
    _            : typedesc[Input];
    key          : glfw.KeyFun             = cb.key;
    mousePos     : glfw.CursorPosFun       = cb.mousePos;
    mouseBtn     : glfw.MouseButtonFun     = cb.mouseBtn;
    mouseScroll  : glfw.ScrollFun          = cb.mouseScroll;
    mouseCapture : bool                    = cfg.nsysMouseCapture;
  ) :Input=
  ## Initializes the system input configuration and its callbacks
  ## Returns a dummy handle for ergonomics when calling input functions.
  doAssert win.ct != nil, "Cannot initialize the input system before the window has been created."
  discard glfw.setKeyCallback(win.ct, key)
  discard glfw.setCursorPosCallback(win.ct, mousePos)
  discard glfw.setMouseButtonCallback(win.ct, mouseBtn)
  discard glfw.setScrollCallback(win.ct, mouseScroll)
  if mouseCapture: glfw.setInputMode(win.ct, glfw.Cursor, glfw.CursorDisabled)
  result = 0.Input # Return a dummy input value
