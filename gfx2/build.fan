#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

using build

class Build : BuildPod
{
  new make()
  {
    podName  = "gfx2"
    summary  = "extension of gfx"
    depends  = ["sys 1.0", "gfx 1.0", "fan3dMath 1.0", "concurrent 1.0", "array 1.0"]
    srcDirs  = [`fan/`]
  }
}