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
    podName  = "fanvas3d"
    summary  = "Fantom 3D lib"
    depends  = ["sys 1.0", "fwt 1.0", "fanvasArray 1.0", "fanvasOpenGl 1.0", "fanvasMath 1.0"]
    srcDirs  = [`fan/`]

    //index = ["compiler.dsl.fanvas3d::Shader": "fanvas3d::ShaderDslPlugin"]
  }
}