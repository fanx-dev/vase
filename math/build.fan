#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-09  Jed Young  Creation
//

using build

class Build : BuildPod
{
  new make()
  {
    podName  = "fan3dMath"
    summary  = "math for 3d transform"
    depends  = ["sys 1.0"]
    srcDirs  = [`fan/`, `test/`]
  }
}