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

**
** FwtEnv the gfx environment implementation for the Fantom Widget Toolkit.
**
@NoDoc
@Js
internal const class FwtEnv2 : GfxEnv2
{
  override native Pixmap load(InStream in)
  override native Pixmap fromUri(Uri uri)
  override native Pixmap makePixmap(Size size)

  static
  {
    Actor.locals["gfx.env2"] = FwtEnv2.make()
  }
}