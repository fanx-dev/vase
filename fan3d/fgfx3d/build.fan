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
    podName  = "fgfx3d"
    summary  = "Fantom 3D lib"
    depends  = ["sys 1.0", "fwt 1.0", "fgfxArray 1.0", "fgfxOpenGl 1.0", "fgfxMath 1.0"]
    srcDirs  = [`fan/`]

    //index = ["compiler.dsl.fgfx3d::Shader": "fgfx3d::ShaderDslPlugin"]
  }
}