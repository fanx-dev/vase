//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fan2d
using concurrent
using fanWt

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
      Button { onAction.add { echo("Hi") }; pos = Point(100, 200); label.text = "Hello" },
      Label { pos = Point(100, 100); text = "Label" },
      ImageView { pos = Point(100, 50); image = ConstImage(`fan://icons/x16/folder.png`) }
    }

    view.win = Window(view)
    view.size = Size(400, 400)
    view.show()
  }

}