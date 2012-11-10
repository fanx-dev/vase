//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfx2d
using concurrent

**
** Toolkit
**
@Js
abstract const class Toolkit
{
  static Toolkit cur()
  {
    Toolkit? env := Actor.locals["fgfxWtk.env"]
    if (env == null) throw Err("No fgfxWtk.env is active")
    return env
  }

  abstract Window build()

  abstract Void callLater(Int delay, |->| f)
}

**
** Default Toolkit maker
**
@Js
class ToolkitEnv
{
  native static Void init()
}