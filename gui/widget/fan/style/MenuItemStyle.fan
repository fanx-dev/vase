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
class MenuItemStyle : WidgetStyle
{
  new make()
  {
    bg = Color.makeRgb(254, 255, 200)
  }

  override Void paint(Widget widget, Graphics g)
  {
    Button btn := widget

    //backgound
    g.brush = bg
    g.fillRect(0, 0, widget.size.w, widget.size.h)
    g.brush = brush
    g.drawRect(0, 0, widget.size.w, widget.size.h)

    //draw text
    g.brush = brush
    g.font = font
    y := btn.size.h / 2
    h := font.height
    g.drawText(btn.text, 15, y+(h/2f).toInt-2)
  }
}