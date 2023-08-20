#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# General usage tools, compatible with all backends  |
#:___________________________________________________|
# n*dk dependencies
import nstd/types as base
import nmath
# n*sys dependencies
import ./backend
when backend.GLFW:
  import ./glfw/types
else: # Native dependencies
  {.error: "n*sys -> Native support is currently not implemented.".}


#_______________________________________
# General Window Tools
#__________________
func ratio *(w :Window) :f32=  w.size.x.float32/w.size.y.float32
  ## Returns the window size ratio as a float32

