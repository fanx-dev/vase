//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using vaseGui


@Js
class CtxMenuTest : BasePage
{
  protected override Widget view() {
    VBox {
        ComboBox {
            items = [
              "comboBox1","comboBox2","comboBox3","comboBox4","comboBox5",
              "comboBox6","comboBox7","comboBox8","comboBox9","comboBox10"
            ]
            selIndex = -1
            text = "ComboBox"
        },
        
        Button {
           text = "Long Press"
           onGestureEvent.add |e|{
              if (e.type == GestureEvent.longPress) {
                  echo("long press")
                  Widget w := e.src
                  CtxMenu {
                    items = [
                     "comboBox1","comboBox2","comboBox3","comboBox4","comboBox5",
                     "comboBox6","comboBox7","comboBox8","comboBox9","comboBox10"
                    ]
                  }.show(w)
              }
           }
        },

        Button {
           text = "Context Menu"
           onGestureEvent.add |GestureEvent e| {
              if (e.type == GestureEvent.click && e.button == 3) {
                  echo("right click: $e.x, $e.y")
                  Widget w := e.src
                  CtxMenu {
                    layout.vAlign = Align.begin
                    layout.hAlign = Align.begin
                    layout.offsetX = w.pixelToDp(e.x)
                    layout.offsetY = w.pixelToDp(e.y)

                    items = [
                     "comboBox1","comboBox2","comboBox3","comboBox4","comboBox5",
                     "comboBox6","comboBox7","comboBox8","comboBox9","comboBox10"
                    ]
                  }.show(w)
              }
           }
        },
    }
  }
}