//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fan2d
using fanWt
using concurrent
using [java]java.lang::Class

**
** Win Test
**
@Js
class Fan2dWinTest
{
  Void main()
  {
    view := MyView()
    win := ToolkitEnv().build(view)
    win.show(Size(400, 400))
  }

}

@Js
class MyView : View
{
  Int i := 0

  override Void onPaint(Graphics g) {
    g.fillRect(20+i, 50, 200, 200)
    g.drawLine(0, 0+i, 400, 400)
    ++i
  }

  override Void onEvent(InputEvent e) {}
}


