#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________

# Alias for ergonomics
const GLFW   * = not defined(nsysNative) or defined(nsysGLFW)
const Native * = defined(nsysNative) and not defined(nsysGLFW)
