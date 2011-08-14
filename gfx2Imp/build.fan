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
    podName  = "gfx2Imp"
    summary  = "implementing of gfx2"
    depends  = ["sys 1.0", "gfx2 1.0", "fwt 1.0", "gfx 1.0", "array 1.0", "fan3dMath 1.0", "concurrent 1.0"]
    srcDirs  = [`fan/`, `test/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}