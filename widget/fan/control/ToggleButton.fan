//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** CheckBox or RadioBox
**
@Js
class ToggleButton : ButtonBase
{
  Bool selected := false
  {
    set
    {
      e := StateChangedEvent (&selected, it, #selected, this )
      onStateChanged.fire(e)
      &selected = it
    }
  }

  protected override Void willClicked() {
    selected = !selected
    this.requestPaint
  }

  protected override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    size := super.prefContentSize(hintsWidth, hintsHeight, result)
    return result.set(size.w+size.h, size.h)
  }
}

@Js
class RadioButton : ToggleButton {
  protected override Void willClicked() {
    if (this.parent == null) {
      super.willClicked
    }
    WidgetGroup group := parent

    if (selected == true) {
      return
    }
    group.each |w| {
      if (w is RadioButton) {
        RadioButton r := w
        if (r.selected) {
          r.selected = false
          r.requestPaint
        }
      }
    }
    selected = true
    this.requestPaint
  }
}