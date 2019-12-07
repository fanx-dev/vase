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
    podName  = "vase3d"
    summary  = "Fantom 3D lib"
    depends  = ["sys 2.0", "std 1.0", "vaseMath 1.0", "vaseOpenGl 1.0"]
    srcDirs  = [`fan/`]

    //index = ["compiler.dsl.vase3d::Shader": "vase3d::ShaderDslPlugin"]
  }
}