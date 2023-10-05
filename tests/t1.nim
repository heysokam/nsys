import std/unittest
import nsys

#_______________________________________
# Debug : Entry Point example
when isMainModule:
  # import ./nsys
  echo nsysPrefix&"Hello Window with Input!"
  var sys = nsys.init(960,540)
  while not sys.close(): sys.update()
  sys.term()
  test "correct sum": check 5+5==10
