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
  @Target { help = "build my app as a single JAR dist" }
  Void dist()
  {
    dist := JarDist(this)
    dist.outFile = `./fan3d.jar`.toFile.normalize
    dist.podNames = Str["array", "fogl", "gfx2", "gfx2Imp", "fan3dMath", "fan3dTouch", "gfx", "fwt",
                        "inet", "concurrent"]
    dist.mainMethod = "fan3dTouch::FwtViewTest.main"
    dist.run
  }
}