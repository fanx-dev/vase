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
      Button { id = "button"; onAction.add { echo("Hi") }; label.text = "Hello" },
      Label { id = "label"; text = "Label" },
      ImageView { id = "image";  image = ConstImage(`fan://icons/x16/folder.png`) },
      TextField { id = "text" },
      ToggleButton { id = "check" },
      ToggleButton { id = "radio" },
      ScrollBar { size = Size(10, 100) },
      ScrollBar { size = Size(100, 10); orientationV = false }
    }

    view.layout = VBox()

    t := Transition()
    t.trans(view.findById("label"))

    view.styleManager.idMap["radio"] = RadioButtonStyle()

    view.size = Size(600, 600)
    view.show
  }

}