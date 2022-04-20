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
class PromptDialog : VBox, Dialog
{
  Label label { private set }
  
  EditText editText { private set }
  
  |Str?|? onAction

  new make(Str msg, Str okText := "OK", Str? cancelText := null)
  {
    this.style = "dialog"
    this.spacing = 0
    
    label = Label {
      it.id = "alertDialog_msg"
      it.text = msg
      it.margin = Insets(20)
      it.textAlign = Align.center
    }
    
    hb := HBox {
        it.spacing = 30
        //it.align = Align.center
        Button {
          it.id = "alertDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(editText.text)
          };
          it.text = okText
        },
    }
    
    if (cancelText != null) {
        bt := Button {
          it.id = "alertDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.close
            onAction?.call(null)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }
    
    editText = EditText {}

    this.add(label)
    this.add(editText)
    //this.add(RectView { it.layout.height = 3.0; it.margin = Insets(30, 0) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.center

    this.layout.width = 600
    padding = Insets(30, 30)
  }
  
  protected override Int animType() { 1 }
  
  override This show(Widget parent) {
    Dialog.super.show(parent)
    editText.focus
    return this
  }

}