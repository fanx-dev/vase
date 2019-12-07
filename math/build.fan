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
    podName  = "vaseMath"
    summary  = "math lib for 3d transformation"
    depends  = ["sys 2.0", "std 1.0", "util 1.0"]
    srcDirs  = [`fan/`, `test/`]
    javaDirs = Uri[,]
  }
}