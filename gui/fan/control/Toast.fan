//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

@Js
class Toast : Label {

  new make(Str msg) {
    text = msg
    layout.width = Layout.wrapContent
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end
    layout.offsetY = -50
//    layout.posX.with { it.parent = 0.5f; it.anchor = 0.5f; it.offset = 0f }
//    layout.posY.with { it.parent = 0.8f; it.anchor = 0.5f; it.offset = 0f }
    padding = Insets(20)
    textAlign = Align.center
  }

  Void show(Widget parent = Frame.cur)
  {
    root := parent.getRootView
    overlayer := root
    overlayer.add(this)
    overlayer.relayout

    a := this.fadeInAnim
    a.whenDone.add {
      this.fadeOutAnim { delay = 1000 }.start
    }
    a.start
  }
}