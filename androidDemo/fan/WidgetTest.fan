//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfxGraphics
using fgfxWtk
using fgfxWidget
//using fgfxFwt
using fgfxAndroid

**
** Win Test
**
@Js
class WinTest
{

  static Void main() {
    ToolkitEnv.init
    WinTest().build.show
  }

  RootView build()
  {
    view := RootView
    {
        LinearLayout
        {
          padding = Insets(50)
          spacing = dpToPixel(15)
          it.layoutParam.width = LayoutParam.matchParent

          Button { id = "button"; text = "Hello Button" },
          ComboBox {
            it.items = ["comboBox1","comboBox2","comboBox3","comboBox4"]
            selectedIndex = 0
          },
          Label { id = "label"; text = "Label"; },
          //ImageView { id = "image";  image = ConstImage(`fan://icons/x16/folder.png`) },
          TextField { hint = "hint" },
          Switch { text = "switch"; it.layoutParam.width = LayoutParam.matchParent },
          ToggleButton { text = "checkBox"; it.layoutParam.width = LayoutParam.matchParent },
          RadioButton { text = "radio1"; it.layoutParam.width = LayoutParam.matchParent },
          RadioButton { text = "radio2"; it.layoutParam.width = LayoutParam.matchParent },
        },
    }

    Button btn := view.findById("button")
    btn.onAction.add
    {
      MessageBox { it.label.text = "hello world" }.show(view)
    }

    echo("dp$btn.dp")

    return view
  }

}