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
  protected override Font font() {
    return getStyle.font
  }

  new make()
  {
  }

  protected override Dimension prefContentSize(Dimension result) {
    return TextView.super.prefContentSize(result)
  }
}

@Js
class Toast : Label {

  new make() {
    layoutParam.widthType = SizeType.wrapContent
    layoutParam.posX.with { it.parent = 0.5f; it.anchor = 0.5f; it.offset = 0f }
    layoutParam.posY.with { it.parent = 0.8f; it.anchor = 0.5f; it.offset = 0f }
    padding = Insets(40)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    overlayer.requestLayout

    a := TweenAnimation() {
      duration = 2000
      AlphaAnimChannel {},
    }
    a.whenDone.add {
      fadeout
    }
    a.run(this)
  }

  Void fadeout() {
    a := TweenAnimation() {
      duration = 2000
      AlphaAnimChannel { from = 1f; to = 0f; },
    }
    a.whenDone.add {
      hide
    }
    a.run(this)
  }

  Void hide()
  {
    WidgetGroup? p := parent
    if (p == null) return

    if (this.hasFocus) {
      p.getRootView.focusIt(null)
    }
    p.remove(this)
    p.requestPaint
    p.getRootView.modal = false
  }
}