//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

//using concurrent
using fanvasGraphics
using fanvasWindow
using fanvasGui
//using fanvasFwt
//using fanvasAndroid

**
** Win Test
**
@Js
class WinTest
{

  static Void main() {
    root := Frame()
    root.mainView = VBox
    {
      padding = Insets((40*2))
      spacing = (15f*2)

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
      TextField { hint = "hint" },
    }

    Button btn := root.findById("button")
    btn.onAction.add
    {
      MessageBox { it.label.text = "hello world" }.show(root)
    }

    root.show
  }
}
