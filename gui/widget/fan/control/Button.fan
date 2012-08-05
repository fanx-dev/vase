//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class Button : ButtonBase
{
  Str text := "button"

  new make()
  {
    size = Size(70, 30)
  }
}