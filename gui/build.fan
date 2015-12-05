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
    podName  = "fanvasGui"
    summary  = "fantom widget"
    depends  = ["sys 1.0", "fanvasGraphics 1.0", "concurrent 1.0", "fanvasMath 1.0", "fanvasWindow 1.0", "fanvasFwt 1.0"]
    srcDirs  = [`fan/`, `fan/animation/`, `fan/container/`, `fan/control/`, `fan/effect/`, `fan/event/`, `fan/style/`, `test/`]
  }
}