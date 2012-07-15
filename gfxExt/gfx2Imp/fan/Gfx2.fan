//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using gfx
using gfx2

using concurrent

@Js
const class Gfx2
{
  **
  ** set Current thread Graphics Engine.
  ** name is one of 'AWT', 'SWT', 'Android'
  **
  static Void setEngine(Str name)
  {
    Actor.locals["gfx.env"] = getEngine(name)
    Actor.locals["gfx.env2"] = getEngine2(name)
    Actor.locals["gfx.EngineName"] = name
  }

  static Str? engineName()
  {
    return Actor.locals["gfx.EngineName"]
  }

  private static native GfxEnv getEngine(Str name)

  private static native GfxEnv2 getEngine2(Str name)
}