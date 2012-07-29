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

    g.drawRect(x-6, y-6, 12, 12)
    if (btn.selected)
    {
      g.drawLine(x-6, y-6, x, y+3)
      g.drawLine(x+8, y-8, x, y+3)
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

    g.drawOval(x-6, y-6, 12, 12)
    if (btn.selected)
    {
      g.fillOval(x-2, y-2, 4, 4)
    }
  }
}