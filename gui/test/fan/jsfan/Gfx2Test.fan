#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fwt
using fgfx2d
using fgfxFwt

using fgfxMath
using fgfxArray

**
** Test Graphics
**
@Js
class Gfx2Test : Canvas
{
  Image p := BufImage.fromUri(`fan://icons/x16/folder.png`) |p|
  {
    //image filter
    for (i:=0; i < p.size.w; ++i)
    {
      for (j:=0; j < p.size.h; ++j)
      {
        c := p.getPixel(i,j)
        p.setPixel(i, j, c.shiftl(16))
      }
    }
  }

  override Void onPaint(gfx::Graphics gc)
  {
    // paint background white
    gc.brush = gfx::Color.white
    gc.fillRect(0, 0, size.w, size.h)

    Graphics g := FwtToolkitEnv.toGraphics(gc)
    paint(g)

    gc.drawLine(10, 10, 100, 200)
    gc.drawOval(10,10, 50,80)
  }

  private Void paint(Graphics g)
  {
    //transform
    trans := Transform2D().scale(0f, 0f, 3f, 3f).translate(10f, 40f).rotate(10f, 10f, -0.5f)
    g.transform = trans


    g.drawImage(p, 10, 10)

    //path test
    path := Path().moveTo(20f, 20f).lineTo(20f, 30f).
      quadTo(25f, 25f, 30f, 15f).cubicTo(40f, 30f, 50f, 40f, 60f, 70f).close

    g.brush = Color.green
    g.fillPath(path)
    g.brush = Color.black
    g.drawPath(path)

    //echo(path.contains(21f, 25f))
    //echo(path.contains(20f, 40f))

    //array
    a := PointArray(2)
    a.setX(0, 10)
    a.setY(0, 50)
    a.setX(1, 50)
    a.setY(1, 70)

    g.drawPolyline(a)

    //save image test
    //out := `file:/D:/temp/fan/swtImage.png`.toFile.out
    //p.save(out)
    //out.close

    //echo(g)
    //g.dispose
  }

  static Void main()
  {
    FwtToolkitEnv.init
    Window
    {
      content = Gfx2Test()
      size = gfx::Size(400, 400)
    }.open
  }
}