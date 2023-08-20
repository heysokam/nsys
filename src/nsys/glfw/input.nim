#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
#:____________________________________________________
# External dependencies
from nglfw as glfw import nil
# n*sys dependencies
import ./types


#_____________________________
proc update *(inp :Input) :void=  glfw.pollEvents()
  ## Orders GLFW to search for input events that happened this frame.

#_____________________________
# GLFW Callbacks
proc key *(win :glfw.Window; key, code, action, mods :cint) :void {.cdecl.}=
  ## GLFW Keyboard Input Callback
  if (key == glfw.KeyEscape and action == glfw.Press):
    glfw.setWindowShouldClose(win, true)

proc mousePos    *(window :glfw.Window; x, y :cdouble) {.cdecl.} = discard
proc mouseBtn    *(window :glfw.Window; button, action, modifiers :cint) {.cdecl.} = discard
proc mouseScroll *(window :glfw.Window; xoffset, yoffset :cdouble) {.cdecl.} = discard

