#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

//using fwt
using vaseGraphics
using vaseWindow
using vaseMath

@Js
class GraphicsTest
{
  Void main()
  {
    view := GraphicsView()
    win := Toolkit.cur.window(view)
  }
}


**
** Test Graphics
**
@Js
class GraphicsView : View
{
  override Window? host

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

  override Void onPaint(Graphics gc)
  {
    // paint background white
    gc.antialias = true
    gc.brush = Color.white
    gc.fillRect(0, 0, host.size.w, host.size.h)

    paint(gc)

    gc.drawLine(10, 10, 100, 200)
    gc.drawOval(10,10, 50,80)
  }

  private Void paint(Graphics g)
  {
    //transform
    trans := Transform2D().scale(0f, 0f, 3f, 3f).translate(10f, 40f).rotate(10f, 10f, -0.5f)
    g.transform(trans)


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
}