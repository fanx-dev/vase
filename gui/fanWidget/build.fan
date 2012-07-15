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
    podName  = "fanWidget"
    summary  = "fantom widget"
    depends  = ["sys 1.0", "fan2d 1.0", "concurrent 1.0", "fan3dMath 1.0", "fanWt 1.0"]
    srcDirs  = [`fan/`, `fan/control/`, `fan/style/`, `test/`]
  }
}