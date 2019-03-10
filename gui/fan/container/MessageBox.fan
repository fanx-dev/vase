//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** MessageBox
**
@Js
class MessageBox : VBox
{
  Label label { private set }

  new make()
  {
    label = Label {
      it.id = "messageBox_msg"
      it.text = "messageBox"
      it.useRenderCache = false
      it.margin = Insets(15)
    }
    btn := Button {
      it.id = "messageBox_ok"
      onAction.add {
        /*
        a := TweenAnimation() {
          AlphaAnimChannel { from = 1f; to = 0f },
        }
        a.whenDone.add |->|{ hide }
        a.run(this)
        */
        this.shrinkAnim.start
      };
      it.text = "OK"
      it.layoutParam.widthType = SizeType.matchParent
      it.useRenderCache = false
    }

    this.add(label)
    this.add(btn)
    //this.layoutParam.hAlign = Align.center
    //this.layoutParam.vAlign = Align.center

    this.layoutParam.posX.with { it.parent = 0.5f; anchor = 0.5f; offset = 0f }
    this.layoutParam.posY.with { it.parent = 0.5f; anchor = 0.5f; offset = 0f }

    this.layoutParam.widthType = SizeType.wrapContent//dpToPixel(500f)
    padding = Insets(50)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = true
    overlayer.relayout
    /*
    a := TweenAnimation() {
      AlphaAnimChannel {},
      TransAnimChannel {},
    }
    a.run(this)
    */
    this.expandAnim.start
  }
  /*
  Void hide()
  {
    WidgetGroup? p := parent
    if (p == null) return

    if (this.hasFocus) {
      p.getRootView.focusIt(null)
    }
    p.remove(this)
    p.repaint
    p.getRootView.modal = false
  }
  */
}