//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class ButtonStyle : WidgetStyle
{
  Color[] colors

  new make()
  {
    colors =
    [
      Color.yellow,
      Color.orange,
      Color.green
    ]
  }

  override Void paint(Widget widget, Graphics g)
  {
    Button btn := widget
    if (btn.state < 3)
    {
      g.brush = colors[btn.state]
    }
    else
    {
      g.brush = bg
    }

    g.fillRect(0, 0, widget.size.w, widget.size.h)

    //draw text
    g.brush = brush
    g.font = font
    x := btn.size.w / 2
    y := btn.size.h / 2
    w := font.width(btn.text)
    h := font.height
    g.drawText(btn.text, x-(w/2f).toInt, y+(h/2f).toInt-2)
  }
}