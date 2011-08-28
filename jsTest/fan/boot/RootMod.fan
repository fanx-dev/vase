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
using concurrent

**
** root mod
**
const class RootMod : PipelineMod
{
  new make() : super(|PipelineMod pp|
  {
    Actor.locals["slanWeb.slanApp"] = SlanApp.makeProduct(this.typeof.pod.name)

    pp.steps =
    [
      SlanRouteMod()
    ]
    //pp.after = [ SlanLogMod(logDir) ]

  }){}
}