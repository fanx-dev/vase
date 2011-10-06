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
    podName = "fan3dTouch"
    summary = "a light weight widget system for touch devices"
    srcDirs = [`test/`, `fan/`, `fan/widget/`, `fan/fwt/`, `fan/event/`]
    depends = ["sys 1.0", "gfx 1.0", "gfx2 1.0", "concurrent 1.0", "fwt 1.0", "gfx2Imp 1.0"]
  }
}
