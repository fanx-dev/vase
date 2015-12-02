//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** A display area for a short text string.
**
@Js
class Label : Widget, TextView
{
  override Str text := "Label"
  override Font font := Font(dpToPixel(41f))

  new make()
  {
  }

  protected override Dimension prefContentSize(Dimension result) {
    return TextView.super.prefContentSize(result)
  }
}