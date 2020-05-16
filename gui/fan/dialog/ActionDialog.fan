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
class ActionDialog : VBox, Dialog
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
    
    this.style = "dialog"
    
    vb := VBox {}
    items.each |item, i|{
        lab := Button {
          it.text = item
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(i)
          };
        }
        vb.add(lab)
    }
    this.add(vb)
    
    if (cancelText != null) {
        this.add(RectView { it.layout.height = 3 })
        
        bt := Button {
          it.id = "actionDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(-1)
          };
          it.text = cancelText
        }
        this.add(bt)
    }

    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end
  }
}