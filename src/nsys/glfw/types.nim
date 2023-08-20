#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
# External dependencies
from nglfw as glfw import nil
# n*dk dependencies
import nstd/types  as base
import nmath/types as m

#_____________________________
type Input * = distinct u8
  ## Dummy object, to pass to the input functions as an argument for ergonomics.

#_____________________________
type Window * = object
  ct     *:glfw.Window
  size   *:UVec2
  title  *:string

