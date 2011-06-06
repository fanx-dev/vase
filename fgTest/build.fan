#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

using build

**
** fan D:/code/Hg/fan3d/fogl/build.fan
**
class Build : BuildPod
{
  new make()
  {
    podName  = "fgTest"
    summary  = "fgTest"
    depends  = ["sys 1.0", "fogl 1.0"]
    srcDirs  = [`fan/`]
  }
}