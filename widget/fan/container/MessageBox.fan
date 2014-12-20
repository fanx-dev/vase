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
** MessageBox
**
@Js
class MessageBox : FrameLayout
{
  Label label { private set }

  new make()
  {
    label = Label { it.id = "messageBox_msg"; it.text = "messageBox" }
    btn := Button { it.id = "messageBox_ok"; onAction.add {
      a := TweenAnimation() {
        AlphaAnimChannel { from = 1f; to = 0f },
      }
      a.whenDone.add |->|{ hide }
      a.run(this)
    }; it.text = "OK" }

    pane := LinearLayout()
    pane.add(label)
    pane.add(btn)
    this.layoutParam.posX = LayoutParam.alignCenter
    this.layoutParam.posY = LayoutParam.alignCenter
    this.layoutParam.width = LayoutParam.wrapContent
    //pane.layoutParam.margin = Insets(dpToPixel(30))
    padding = Insets(dpToPixel(30))
    this.add(pane)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    root.add(this)
//    this.pos = Point(root.size.w/2 - this.size.w/2, root.size.h/2 - this.size.h/2)
    this.focus
    root.modal = true
    this.requestLayout
    
    a := TweenAnimation() {
      AlphaAnimChannel {},
      TransAnimChannel {},
    }
    a.run(this)
  }

  Void hide()
  {
    WidgetGroup? p := parent
    if (p == null) return
    
    if (this.hasFocus) {
      (p as RootView).focusIt(null)
    }
    p.remove(this)
    //p.requestLayout
    p.requestPaint
    (p as RootView).modal = false
  }
}