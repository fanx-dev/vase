#! /usr/bin/env fan
//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-9-22  Jed Young  Creation
//

using build

class Build : BuildScript
{
  @Target { help = "build as a single JAR dist" }
  Void dist()
  {
    dist := JarDist(this)
    //dist.outFile = `./ROOT/WEB-INF/lib/myapp_deploy.jar`.toFile.normalize
    dist.outFile = `file:/D:/Temp/fgTest.jar`.toFile.normalize
    dist.podNames = Str["fogl", "fgTest"]
    dist.mainMethod = "fgTest::Display.main"
    dist.run
  }
}