//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   30 Apr 09  Brian Frank  Creation
//

using concurrent

**
** GfxEnv models an implementation of the gfx graphics API.
**
@NoDoc
@Js
abstract const class GfxEnv
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
  static GfxEnv? cur(Bool checked := true)
  {
    GfxEnv? env := Actor.locals["gfx3.env"]
    if (env != null) return env
    if (checked) throw Err("No GfxEnv3 is active")
    return null
  }


//////////////////////////////////////////////////////////////////////////
// Font Support
//////////////////////////////////////////////////////////////////////////

  **
  ** make font
  **
  abstract Font makeFont(|Font| f)

//////////////////////////////////////////////////////////////////////////
// Image op
//////////////////////////////////////////////////////////////////////////

  abstract Image fromUri(Uri uri, |Image| onLoad)
  abstract ConstImage makeConstImage(Uri uri)
  abstract Image makeImage(Size size)
  abstract Image fromStream(InStream in)

//////////////////////////////////////////////////////////////////////////
// Other
//////////////////////////////////////////////////////////////////////////

  abstract Bool contains(Path path, Float x, Float y)
  abstract PointArray makePointArray(Int size)

}