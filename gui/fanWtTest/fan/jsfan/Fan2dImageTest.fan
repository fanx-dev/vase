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

**
** Image Test
**
@Js
class Fan2dImageTest
{
  Void main()
  {
    ToolkitEnv.init

    view := MyImageView()
    win := ToolkitEnv.build(view)
    view.win = win

    win.show(Size(400, 400))
  }

}

@Js
class MyImageView : View
{
  Int i := 0

  Window? win

  Image p := BufImage.fromUri(`fan://icons/x16/folder.png`) |p|
  {
    //image filter
    for (i:=0; i < p.size.w; ++i)
    {
      for (j:=0; j < p.size.h; ++j)
      {
        c := p.getPixel(i,j)
        //echo(c)
        c = c.and(0xffff0000)
        //echo(c)
        p.setPixel(i, j, c)
      }
    }
  }

  new make()
  {
  }

  override Void onPaint(Graphics g) {
    g.drawImage(p, 0, 0)
  }

  override Void onEvent(InputEvent e) {}
}


