#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# std dependencies
import std/strformat
# External dependencies
from nglfw as glfw import nil
# n*sys dependencies
import ../cfg

#___________________________________________________________________
# Window Callbacks
#_______________________________________
proc error *(code :int32; desc :cstring) :void {.cdecl, discardable.} =
  ## GLFW error callback. Just echoes messages to the terminal.
  ## Implement your own function and send it as an argument to the constructor if you want different behavior.
  echo cfg.glfwPrefix, &": [Error]:{$code}\n  {$desc}"
#__________________
proc resize *(window :glfw.Window; W,H :cint) :void {.cdecl.}= discard
  ## Dummy GLFW FrameBufferSize callback. Does nothing.
  ## Only for reference. Behavior on window resize is extremely application dependent.


#___________________________________________________________________
# Input Callbacks
proc key *(win :glfw.Window; key, code, action, mods :cint) :void {.cdecl.}=
  ## GLFW Keyboard Input Callback
  if (key == glfw.KeyEscape and action == glfw.Press):
    glfw.setWindowShouldClose(win, true)
  # if action == glfw.PRESS: echo "Pressed key | id:",$key, " code:",$code

proc mousePos    *(window :glfw.Window; x, y :cdouble) {.cdecl.} = discard
proc mouseBtn    *(window :glfw.Window; button, action, modifiers :cint) {.cdecl.} = discard
proc mouseScroll *(window :glfw.Window; xoffset, yoffset :cdouble) {.cdecl.} = discard

