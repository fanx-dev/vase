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
      Button { onAction.add { echo("Hi") }; label.text = "Hello" },
      Label { text = "Label" },
      ImageView { image = ConstImage(`fan://icons/x16/folder.png`) }
    }

    view.layout = VBox()

    view.win = Window(view)
    view.size = Size(400, 400)
    view.show()
  }

}