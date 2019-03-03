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
    podName = "fanvasAndroid"
    summary = "fanvasWindow android impl"
    srcDirs = [`fan/`]
    depends = ["sys 2.0", "std 1.0", "fanvasGraphics 1.0", "fanvasWindow 1.0", "concurrent 1.0", "fanvasMath 1.0"]
    javaDirs = [`java/`]
  }
}