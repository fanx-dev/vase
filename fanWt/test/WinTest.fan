//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fan2d
using concurrent
using [java]java.lang::Class


class MyView : View
{
  override Void onPaint(Graphics g) {
    g.fillRect(20, 50, 200, 200)
    g.drawLine(0, 00, 400, 400)
  }

  override Void onEvent(InputEvent e) {}
}

**
** Win Test
**
@Js
class WinTest
{
  Void main()
  {
    view := MyView()
    win := ToolkitEnv().build(view)
    win.show(Size(400, 400))
  }

}