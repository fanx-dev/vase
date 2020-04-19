//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using vaseMath

**
** Image Test
**
@Js
class ImageTest
{
  Void main()
  {
    view := MyImageView()
    win := Toolkit.cur.window(view)
  }
}

@Js
class MyImageView : View
{
  Int i := 0

  override Window? host

  Image p := Image.fromUri(`image.png`) |p|
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
}


