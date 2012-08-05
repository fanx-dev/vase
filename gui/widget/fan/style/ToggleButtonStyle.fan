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
class ToggleButtonStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget

    g.brush = brush
    x := btn.size.w / 2
    y := btn.size.h / 2

    r := ((x.min(y)-1) * 0.8f).toInt
    g.drawRect(x-r, y-r, r*2, r*2)
    if (btn.selected)
    {
      g.drawLine(x-(r*0.8f).toInt, y-(r*0.7f).toInt, x, y+(r/2f).toInt)
      g.drawLine(x+(r*1.3f).toInt, y-(r*1.3f).toInt, x, y+(r/2f).toInt)
    }
  }
}

@Js
class RadioButtonStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget

    g.brush = brush
    x := btn.size.w / 2
    y := btn.size.h / 2

    r := x.min(y) -1
    g.drawOval(x-r, y-r, r*2, r*2)
    if (btn.selected)
    {
      cw := (r*0.7f).toInt
      g.fillOval(x-(r/3f).toInt, y-(r/3f).toInt, cw, cw)
    }
  }
}