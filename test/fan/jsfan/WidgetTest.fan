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
using fgfxFwt

**
** Win Test
**
@Js
class WinTest
{
  Bool initEnv() {
    if (Env.cur.runtime != "java") {
      ToolkitEnv.init
      return true
    }
    if (Env.cur.args.size > 0) {
      if (Env.cur.args.first == "AWT") {
        ToolkitEnv.init
        return true
      }
      else if (Env.cur.args.first == "SWT") {
        FwtToolkitEnv.init
        return true
      }
    }
    echo("AWT or SWT ?")
    return false
  }

  Void main()
  {
    if (!initEnv) return

    view := RootView
    {
      //ScrollPane
      //{
        LinearLayout
        {
          padding = Insets(20)
          spacing = dpToPixel(15)
          Button { id = "button"; text = "Hello Button" },
          ComboBox {
            it.items = ["comboBox1","comboBox2","comboBox3","comboBox4"]
            selectedIndex = 0
          },
          Label { id = "label"; text = "Label"; effect = ShadowEffect() },
          ImageView { id = "image";  image = ConstImage(`fan://icons/x16/folder.png`) },
          TextField { id = "text" },
          Switch { text = "switch"; it.layoutParam.width = LayoutParam.matchParent },
          ToggleButton { text = "checkBox"; it.layoutParam.width = LayoutParam.matchParent },
          RadioButton { text = "radio1"; it.layoutParam.width = LayoutParam.matchParent },
          RadioButton { text = "radio2"; it.layoutParam.width = LayoutParam.matchParent },
        },
//      },
    }

    label := view.findById("label")
    a := TweenAnimation() {
      AlphaAnimChannel {},
//      ScaleAnimChannel {},
      TransAnimChannel {},
    }
    a.run(label)

    Button btn := view.findById("button")
    btn.onAction.add
    {
      MessageBox { it.label.text = "hello world" }.show(view)
    }

    view.show
  }

}