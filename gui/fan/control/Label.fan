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

  protected override Dimension prefContentSize() {
    w := font.width(text)
    h := font.height
    return Dimension(w, h)
  }
}

@Js
class Toast : Label {

  new make() {
    layoutParam.widthType = SizeType.wrapContent
    this.layoutParam.hAlign = Align.center
    this.layoutParam.vAlign = Align.end
    layoutParam.offsetY = -50f
//    layoutParam.posX.with { it.parent = 0.5f; it.anchor = 0.5f; it.offset = 0f }
//    layoutParam.posY.with { it.parent = 0.8f; it.anchor = 0.5f; it.offset = 0f }
    padding = Insets(20)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    overlayer.relayout

    a := this.fadeInAnim
    a.whenDone.add {
      this.fadeOutAnim { delay = 1000 }.start
    }
    a.start
  }
}