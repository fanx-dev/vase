//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfx2d
using fgfxWtk
using fgfxWidget

**
** Win Test
**
@Js
class WinTest
{
  Void main()
  {
    ToolkitEnv.init

    view := RootView
    {
      ScrollPane
      {
        WidgetGroup
        {
          layout = VBox()

          Button { id = "button"; text = "Hello" },
          ComboBox { it.items = ["one","two","three","four"]; selectedIndex = 0 },
          Label { id = "label"; text = "Label" },
          ImageView { id = "image";  image = ConstImage(`fan://icons/x16/folder.png`) },
          TextField { id = "text" },
          ToggleButton { id = "check" },
          ToggleButton { id = "radio"; styleClass = "radio" },
        },
      },
    }

    t := Transition()
    t.trans(view.findById("label"))

    Button btn := view.findById("button")
    btn.onAction.add
    {
      MessageBox { it.label.text = "hello world" }.show(view)
    }

    view.size = Size(600, 600)
    view.show
  }

}