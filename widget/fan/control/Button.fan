//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** Text push button
**
@Js
class Button : ButtonBase
{
  new make() {
    padding = Insets(dpToPixel(20))
  }
}