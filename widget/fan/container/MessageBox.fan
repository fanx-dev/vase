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
class MessageBox : LinearLayout
{
  Label label { private set }

  new make()
  {
    label = Label {
      it.id = "messageBox_msg"
      it.text = "messageBox"
      it.staticCache = false
      it.layoutParam.margin = Insets(30)
    }
    btn := Button {
      it.id = "messageBox_ok"
      onAction.add {
        a := TweenAnimation() {
          AlphaAnimChannel { from = 1f; to = 0f },
        }
        a.whenDone.add |->|{ hide }
        a.run(this)
      };
      it.text = "OK"
      it.layoutParam.width = LayoutParam.matchParent
      it.staticCache = false
    }

    this.add(label)
    this.add(btn)
    this.layoutParam.posX = LayoutParam.alignCenter
    this.layoutParam.posY = LayoutParam.alignCenter
    this.layoutParam.width = LayoutParam.wrapContent
    padding = Insets(dpToPixel(40f))
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = true
    overlayer.layout

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
      p.getRootView.focusIt(null)
    }
    p.remove(this)
    p.requestPaint
    p.getRootView.modal = false
  }
}