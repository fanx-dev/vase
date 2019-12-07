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
    podName = "vaseDemo"
    summary = "vaseWindow mobile demo"
    srcDirs = [`fan/`]
    depends = ["sys 2.0", "std 1.0", "vaseGraphics 1.0", "vaseWindow 1.0"
               , "concurrent 1.0", "vaseMath 1.0", "vaseAndroid 1.0", "vaseGui 1.0"]
  }

  @Target { help = "build my app as a single JAR dist" }
  Void dist()
  {
    dist := JarDist(this)
    dist.outFile = (scriptDir+`android/app/libs/androidDemo.jar`).normalize
    dist.podNames = Str["sys", "std", "concurrent", "vaseGraphics", "vaseWindow", "vaseMath", "vaseGui"
           , "vaseAndroid", "vaseDemo", "util", "vaseClient"]
    dist.mainMethod = "vaseDemo::WinTest.main"
    dist.run
  }
}