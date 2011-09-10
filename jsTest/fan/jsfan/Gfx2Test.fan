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
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Gfx2Test.fan
**
@Js
class Gfx2Test : Canvas2
{
  Image2 p := Image2.fromUri(`fan://icons/x16/folder.png`) |p|
  {
    //image filter
    for (i:=0; i < p.size.w; ++i)
    {
      for (j:=0; j < p.size.h; ++j)
      {
        c := p.getPixel(i,j)
        nc := Color.makeArgb(c.a, c.r, 0, 0)
        p.setPixel(i, j, nc)
      }
    }
  }

  override Void onPaint(Graphics gc)
  {
    Graphics2 g := gc

    //transform
    trans := Transform2D().scale(0f, 0f, 3f, 3f).translate(10f, 40f).rotate(10f, 10f, 0.5f)
    g.setTransform(trans)


    g.drawImage2(p, 10, 10)

    //path test
    path := Path().moveTo(20f, 20f).lineTo(20f, 30f).
      quadTo(25f, 25f, 30f, 15f).cubicTo(40f, 30f, 50f, 40f, 60f, 70f).close

    g.brush = Color.green
    g.fillPath(path)
    g.brush = Color.black
    g.drawPath(path)

    echo(path.contains(21f, 25f))
    echo(path.contains(20f, 40f))

    //array
    a := Array.allocate(4)
    a.setInt(0, 10)
    a.setInt(1, 50)
    a.setInt(2, 50)
    a.setInt(3, 70)
    g.drawPolyline2(a)

    //save image test
    //out := `file:/D:/temp/fan/swtImage.png`.toFile.out
    //p.save(out)
    //out.close

    echo(g)
    echo(Gfx2.engineName)
  }

  static Void main()
  {
    //Gfx2.setEngine("AWT")
    Window
    {
      content = Gfx2Test()
      size = Size(400, 400)
    }.open
  }
}