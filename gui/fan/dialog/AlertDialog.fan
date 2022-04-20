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
class AlertDialog : VBox, Dialog
{
  Label label { private set }
  
  |Bool|? onAction

  new make(Str msg, Str? okText := "OK", Str? cancelText := null)
  {
    this.style = "dialog"
    this.spacing = 0
    
    label = Label {
      it.id = "alertDialog_msg"
      it.text = msg
      it.margin = Insets(20)
      it.textAlign = Align.center
      it.layout.width = Layout.wrapContent
      it.layout.hAlign = Align.center
    }
    this.add(label)
    
    hb := HBox {
        it.spacing = 30
        it.align = Align.center
        it.layout.width = Layout.wrapContent
    }

    if (okText != null) {
        bt := Button {
          it.layout.width = 300
          it.id = "alertDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(true)
          };
          it.text = okText
        }
        hb.add(bt)
    }
    else {
      this.add(ProgressView {
        it.layout.width = 300
      })
    }

    
    if (cancelText != null) {
        bt := Button {
          it.layout.width = 300
          it.id = "alertDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(false)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }

    
    //this.add(RectView { it.layout.height = 3.0; it.margin = Insets(30, 0) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.center

    this.layout.width = Layout.wrapContent
    padding = Insets(30, 30)
  }
  
  protected override Int animType() { 1 }

}