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
    podName  = "vaseOpenGl"
    summary  = "Fantom OpenGL/WebGL Binding"
    depends  = ["sys 2.0", "std 1.0", "util 1.0"]
    srcDirs  = [`fan/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}