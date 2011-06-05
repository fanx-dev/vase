//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2010-12-7  Jed Young  Creation
//

using slanWeb::SlanApp
using slanWeb::SlanRouteMod
using slanWeb::SlanLogMod
using webmod

**
** root mod
**
const class RootMod : PipelineMod
{
  new make(SlanApp? slanApp := null) : super(|PipelineMod pp|
  {
    pp.steps =
    [
      SlanRouteMod(slanApp ?: SlanApp.makeProduct(Main#.pod.name))
      {
        //you can add your mod at here
        it["doc"] = FileMod { file = Env.cur.homeDir + `doc/` }
        //it["log"] = FileMod { file = logDir.toFile }
      }
    ]
    //pp.after = [ SlanLogMod(logDir) ]

  }){}
}