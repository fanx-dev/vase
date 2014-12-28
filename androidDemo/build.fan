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
    podName = "fgfxAndroidDemo"
    summary = "fgfxWtk android demo"
    srcDirs = [`fan/`]
    depends = ["sys 1.0", "fgfxGraphics 1.0", "fgfxWtk 1.0"
               , "concurrent 1.0", "fgfxMath 1.0", "fgfxAndroid 1.0", "fgfxWidget 1.0"]
  }

  @Target { help = "build my app as a single JAR dist" }
  Void dist()
  {
    dist := JarDist(this)
    dist.outFile = (scriptDir+`android/libs/androidDemo.jar`).normalize
    dist.podNames = Str["concurrent", "fgfxGraphics", "fgfxWtk", "fgfxArray", "fgfxMath", "fgfxWidget"
           , "fgfxAndroid", "fgfxAndroidDemo"]
    dist.mainMethod = "fgfxAndroidDemo::WinTest.main"
    dist.run
  }
}