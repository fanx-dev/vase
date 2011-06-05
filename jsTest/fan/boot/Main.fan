//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-9-22  Jed Young  Creation
//

using slanWeb::CommandLine
using wisp

**
** Main
**
class Main : CommandLine
{
  override Int run()
  {
    init
    //init service
    wisp := WispService
    {
      it.port = Main#.pod.config("port", "8081").toInt
      it.root = RootMod()
    }

    //run service
    asyRunService([wisp])

    //read command line input
    processInput()

    return -1
  }

  **
  ** for jsDist to init classPath
  **
  static Void init() {}
}