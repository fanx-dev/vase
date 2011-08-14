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
    summary  = "math lib for 3d transformation"
    depends  = ["sys 1.0"]
    srcDirs  = [`fan/`, `test/`]
    javaDirs = Uri[,]
  }
}