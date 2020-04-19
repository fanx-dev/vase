//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

//using concurrent
using vaseGraphics
using vaseWindow
using vaseGui
//using vaseFwt
//using vaseAndroid

**
** Win Test
**
@Js
class WinTest
{

  static Void main() {
    root := Frame {
      VBox
      {
        padding = Insets(40)
        spacing = 15f

        Button { id = "button"; text = "Hello Button" },
        ComboBox {
          it.items = ["comboBox1","comboBox2","comboBox3","comboBox4"]
          selectedIndex = 0
        },
        Label { id = "label"; text = "Label"; },
        //ImageView { id = "image";  image = ConstImage(`fan://icons/x16/folder.png`) },

        Switch { text = "switch"; },
        ToggleButton { text = "checkBox"; },
        RadioButton { text = "radio1"; },
        RadioButton { text = "radio2"; },
        EditText { hint = "hint" },
      },
    }

    Button btn := root.findById("button")
    btn.onAction.add
    {
      msg := Toolkit.cur.density.toStr + "," + root.width
      MessageBox { it.label.text = msg }.show(root)
    }

    root.show
  }
}
