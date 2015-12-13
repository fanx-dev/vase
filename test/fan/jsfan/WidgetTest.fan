//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasWindow
using fanvasGui
using fanvasFwt

**
** Win Test
**
@Js
class WidgetTest : BaseTestWin
{
  protected override Widget build() {
    LinearLayout
    {
      padding = Insets(100)
      spacing = 30f
      Button { id = "button"; text = "Hello Button" },
      ComboBox {
        it.items = ["comboBox1","comboBox2","comboBox3","comboBox4"]
        selectedIndex = 0
      },
      Label { id = "label"; text = "Label"; },
      ImageView { id = "image";  uri = (`fan://icons/x16/folder.png`) },
      TextField { hint = "hint" },
      Switch { text = "switch" },
      ToggleButton { text = "checkBox" },
      RadioButton { text = "radio1" },
      RadioButton { text = "radio2" },
    }
  }

  protected override Void init(RootView root) {

    label := root.findById("label")
    a := TweenAnimation() {
      AlphaAnimChannel {},
//      ScaleAnimChannel {},
      TransAnimChannel {},
    }
    a.run(label)

    Button btn := root.findById("button")
    btn.onAction.add
    {
      MessageBox { it.label.text = "hello world" }.show(root)
    }
  }

}