#:____________________________________________________
#  nsys  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  :
#:____________________________________________________
import std/[ os,strformat ]

#_____________________________
# Package
packageName   = "nsys"
version       = "0.0.0"
author        = "sOkam"
description   = "n*sys | System-specific Interaction tools"
license       = "MIT"

#_____________________________
# Build Requirements
requires "nim >= 2.0.0"

#_____________________________
# Folders
srcDir          = "src"
binDir          = "bin"
installExt      = @["nim"]
let docDir      = "doc"
let testsDir    = "tests"
let examplesDir = "examples"

#_____________________________
# Binaries
backend       = "c"
bin           = @[packageName]

#________________________________________
# Helpers
#___________________
const vlevel = when defined(debug): 2 else: 1
let nimcr  = &"nim c -r --verbosity:{vlevel} --outdir:{binDir}"
  ## Compile and run, outputting to binDir
proc runFile (file, dir, args :string) :void=  exec &"{nimcr} {dir/file} {args}"
  ## Runs file from the given dir, using the nimcr command, and passing it the given args
proc runFile (file :string) :void=  file.runFile( "", "" )
  ## Runs file using the nimcr command
proc runTest (file :string) :void=  file.runFile(testsDir, "")
  ## Runs the given test file. Assumes the file is stored in the default testsDir folder
proc runExample (file :string) :void=  file.runFile(examplesDir)
  ## Runs the given test file. Assumes the file is stored in the default testsDir folder
template example (name :untyped; descr,file :static string)=
  ## Generates a task to build+run the given example
  let sname = astToStr(name)  # string name
  taskRequires sname, "SomePackage__123"  ## Doc
  task name, descr:
    runExample file


#_________________________________________________
# Tasks: Internal
#___________________
task push, "Internal Pushes the git repository, and orders to create a new git tag for the package, using the latest version.":
  ## Does nothing when local and remote versions are the same.
  requires "https://github.com/beef331/graffiti.git"
  exec "git push"  # Requires local auth
  exec "graffiti ./confy.nimble"
#___________________
task tests, "Internal:  Builds and runs all tests in the testsDir folder.":
  for file in testsDir.listFiles():
    if file.lastPathPart.startsWith('t'):
      try: runFile file
      except: echo &" └─ Failed to run one of the tests from  {file}"

