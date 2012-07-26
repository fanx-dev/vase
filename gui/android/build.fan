#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using build
class Build : build::BuildPod
{
  new make()
  {
    podName = "fgfxAndroid"
    summary = "fgfxWtk android impl"
    srcDirs = [`fan/`]
    depends = ["sys 1.0", "fgfx2d 1.0", "fgfxWtk 1.0", "concurrent 1.0", "fgfxMath 1.0"]
    javaDirs = [`java/`]
  }
}