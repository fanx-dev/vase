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
  new make(Uri? path := null) : super(|PipelineMod pp|
  {
    app := path == null ? SlanApp.makeProduct(this.typeof.pod.name) : SlanApp.makeDebug(path)

    pp.steps =
    [
      SlanRouteMod(app)
    ]
    //pp.after = [ SlanLogMod(logDir) ]

  }){}
}