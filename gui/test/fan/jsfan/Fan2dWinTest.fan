//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fgfx2d
using fgfxWtk
using concurrent
using fgfxMath

**
** Win Test
**
@Js
class Fan2dWinTest
{
  Void main()
  {
    ToolkitEnv.init

    view := MyView()
    win := Window(view)
    view.win = win

    win.show(Size(400, 400))
  }

}

@Js
class MyView : View
{
  Int i := 0

  ConstImage? img

  Window? win

  new make()
  {
    img = ConstImage.make(`fan://icons/x16/folder.png`)
  }

  override Void onPaint(Graphics g) {
    g.fillRect(20+i, 50, 200, 200)
    g.drawLine(0, 0+i, 400, 400)
    ++i
    g.drawImage(img, 0, 0)
  }

  override Void onEvent(InputEvent e) {}
}


