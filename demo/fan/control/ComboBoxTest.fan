//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using vaseGui

**
** Win Test
**
@Js
class ComboBoxTest : BasePage
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
           onLongPress {
              echo("long press")
              CtxMenu {
                items = [
                 "comboBox1","comboBox2","comboBox3","comboBox4","comboBox5",
                 "comboBox6","comboBox7","comboBox8","comboBox9","comboBox10"
                ]
              }.show(it)
           }
        },
    }
  }
}