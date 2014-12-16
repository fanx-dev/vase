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
    podName  = "fgfxFwt"
    summary  = "Fwt implementation"
    depends  = ["sys 1.0", "fgfxGraphics 1.0", "fgfxWtk 1.0", "fwt 1.0", "gfx 1.0", "concurrent 1.0", "fgfxMath 1.0"]
    srcDirs  = [`fan/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}