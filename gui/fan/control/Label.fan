//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** A display area for a short text string.
**
@Js
class Label : Widget
{
  Align textAlign := Align.begin
  
  Str text := "Label" {
    set {
      &text = it
      this.repaint
    }
  }
  protected Font font() {
    return getStyle.font
  }

  new make()
  {
  }

  protected override Size prefContentSize() {
    w := font.width(text)
    h := font.height
    return Size(w, h)
  }
}
