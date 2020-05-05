//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** MessageBox
**
@Js
class ActionDialog : VBox
{
  Str[] items
  
  |Int|? onAction

  new make(Str msg, Str[] items, Str? cancelText)
  {
    this.items = items
    
    label := Label {
      it.id = "actionBox_msg"
      it.text = msg
      it.margin = Insets(20)
      it.textAlign = Align.center
    }
    this.add(label)
    
    this.style = "actionList"
    vb := VBox {}
    items.each |item, i|{
        lab := Button {
          it.text = item
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(i)
          };
        }
        vb.add(lab)
    }
    this.add(vb)
    
    if (cancelText != null) {
        this.add(RectView { it.layout.height = 3.0 })
        
        bt := Button {
          it.id = "actionDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(-1)
          };
          it.text = cancelText
        }
        this.add(bt)
    }

    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = 2
    overlayer.relayout
    this.moveInAnim(Direction.down).start
  }
}