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

  @Transient private Size? sizeCache := null
  @Transient private Font? fontCache := null
  
  Str text := "Label" {
    set {
      &text = it
      sizeCache = null
      this.relayout
    }
  }
  protected Font font() {
    return getStyle.font(this)
  }

  new make()
  {
    padding = Insets(1)
  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    if (sizeCache != null) {
      if (fontCache === font) {
        return sizeCache
      }
    }
    w := font.width(text)+5
    h := font.height
    sizeCache = Size(w, h)
    return sizeCache
  }
}
