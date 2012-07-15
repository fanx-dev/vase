#! /usr/bin/env fan
//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-9-22  Jed Young  Creation
//

using build
using slanWeb

class Build : build::BuildPod
{
  new make()
  {
    podName = "gfx2Test"
    summary = "test fan3d in web"
    srcDirs = [`fan/`, `fan/model/`, `fan/action/`, `fan/jsfan/`, `fan/boot/`, `fan/util/`]
    depends =
    [
      "sys 1.0",
      "webmod 1.0",
      "web 1.0",
      "compiler 1.0",
      "wisp 1.0",
      "concurrent 1.0",
      "slanWeb 1.0",
      "slanUtil 1.0",
      "dom 1.0",
      "gfx 1.0",
      "fwt 1.0",
      "fan3dMath 1.0",
      "array 1.0",
      "gfx2 1.0",
      "gfx2Imp 1.0",
    ]
    resDirs =
    [,].addAll(Util.allDir(scriptDir.uri, `res/view/`)).
      addAll(Util.allDir(scriptDir.uri, `public/`))
  }
}