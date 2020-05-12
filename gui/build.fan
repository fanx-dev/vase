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
    podName  = "vaseGui"
    summary  = "fantom widget"
    depends  = ["sys 2.0", "std 1.0", "vaseGraphics 1.0", "concurrent 1.0", "vaseMath 1.0", "vaseWindow 1.0"]
    srcDirs  = [`fan/`, `fan/animation/`, `fan/container/`, `fan/control/`, `fan/dialog/`, `fan/effect/`, `fan/event/`, `fan/style/`, `test/`]
  }
}