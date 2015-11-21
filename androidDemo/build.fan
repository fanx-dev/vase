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
    podName = "fanvasAndroidDemo"
    summary = "fanvasWindow android demo"
    srcDirs = [`fan/`]
    depends = ["sys 1.0", "fanvasGraphics 1.0", "fanvasWindow 1.0"
               , "concurrent 1.0", "fanvasMath 1.0", "fanvasAndroid 1.0", "fanvasGui 1.0"]
  }

  @Target { help = "build my app as a single JAR dist" }
  Void dist()
  {
    dist := JarDist(this)
    dist.outFile = (scriptDir+`android/libs/androidDemo.jar`).normalize
    dist.podNames = Str["concurrent", "fanvasGraphics", "fanvasWindow", "fanvasArray", "fanvasMath", "fanvasGui"
           , "fanvasAndroid", "fanvasAndroidDemo"]
    dist.mainMethod = "fanvasAndroidDemo::WinTest.main"
    dist.run
  }
}