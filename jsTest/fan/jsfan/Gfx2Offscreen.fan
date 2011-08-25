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

    g.brush = Color.black
    g.drawText("Hello \nWorld", 20, 100)

    trans := Transform2D().scale(0f, 0f, 3f, 3f).rotate(10f, 10f, 0.5f)
    g.setTransform(trans)
    g.brush = Color.black
    g.fillRect(10,10,10,10)

    g.dispose
  }

  Pixmap p := Pixmap(Size(310,310))

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