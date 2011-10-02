#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using gfx
using fwt

using gfx2
using gfx2Imp
using fan3dMath
using array

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Gfx2Offscreen.fan
**
@Js
class Gfx2Offscreen : Canvas2
{
  new make()
  {
    Graphics2 g := p.graphics

    g.brush = Color.yellow
    g.fillRect(5,5,300,300)

    g.brush = Color.red
    g.fillRect(0,0,5,5)

    g.brush = Color.black
    x := 100
    y := 10
    g.drawText("Hello \nWorld", x, y)

    trans := Transform2D().rotate(0f, 0f, 0.5f)
    g.setTransform(trans)
    g.drawText("Hello \nWorld", x, y)

    trans = Transform2D().rotate(x.toFloat, y.toFloat, 0.5f)
    g.setTransform(trans)
    g.drawText("Hello \nWorld", x, y)

    g.dispose
  }

  Image2 p := Image2(Size(310,310))

  override Void onPaint(Graphics gc)
  {
    (gc as Graphics2).drawImage2(p, 10, 10)
  }

  Void main()
  {
    Window
    {
      content = Gfx2Offscreen()
      it.size = Size(400, 400)
    }.open
  }
}