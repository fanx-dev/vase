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
    view := RootView()
    btn := Button { onAction.add { echo("Hi") }; pos = Point(100, 200); text = "Hello" }
    view.add(btn)
    view.win = Window(view)
    view.size = Size(400, 400)
    view.show()
  }

}