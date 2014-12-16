//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

@Js
class ButtonBaseStyle : WidgetStyle
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

  override Void doPaint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget
    if (btn.state < 3)
    {
      g.brush = colors[btn.state]
    }
    else
    {
      g.brush = background
    }

    g.fillRect(0, 0, widget.width, widget.height)

    //draw text
    g.brush = brush
    g.font = btn.font
    x := widget.padding.left + (widget.getContentWidth / 2)
    y := widget.padding.top + (widget.getContentHeight / 2)
    w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, x-(w/2f).toInt, y-(h/2f).toInt+offset)
  }
}