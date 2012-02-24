#! /usr/bin/env fan
//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using build

class Build : BuildPod
{
  new make()
  {
    podName  = "fan3d"
    summary  = "Fantom 3D lib"
    depends  = ["sys 1.0", "fwt 1.0", "gfx 1.0", "array 1.0", "fogl 1.0", "fan3dMath 1.0", "compiler 1.0"]
    srcDirs  = [`fan/`, `test/`]

    index = ["compiler.dsl.fan3d::Shader": "fan3d::ShaderDslPlugin"]
  }
}