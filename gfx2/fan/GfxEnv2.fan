//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   30 Apr 09  Brian Frank  Creation
//

using concurrent
using gfx

**
** GfxEnv2 models an implementation of the gfx2 graphics API.
**
@NoDoc
@Js
abstract const class GfxEnv2
{

//////////////////////////////////////////////////////////////////////////
// Access
//////////////////////////////////////////////////////////////////////////

  **
  ** Get the current thread's graphics environment.  If no
  ** environment is active then throw Err or return null based
  ** on checked flag.  The current environment is configured
  ** with the "gfx.env" Actor local.
  **
  static GfxEnv2? cur(Bool checked := true)
  {
    GfxEnv2? env := Actor.locals["gfx.env2"]
    if (env != null) return env
    if (checked) throw Err("No GfxEnv2 is active")
    return null
  }

//////////////////////////////////////////////////////////////////////////
// Image op
//////////////////////////////////////////////////////////////////////////

  abstract Pixmap fromUri(Uri uri)
  abstract Pixmap makePixmap(Size size)

  abstract Bool contains(Path path, Float x, Float y)
}