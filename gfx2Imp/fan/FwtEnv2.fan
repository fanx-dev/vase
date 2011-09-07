//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using gfx
using gfx2

**
** FwtEnv the gfx environment implementation for the Fantom Widget Toolkit.
**
@NoDoc
@Js
internal const class FwtEnv2 : GfxEnv2
{
  override native Image2 fromUri(Uri uri, |Image2| onLoad)
  override native Image2 makeImage2(Size size)
  override native Bool contains(Path path, Float x, Float y)

  native Void disposeAll()
}