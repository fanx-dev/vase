//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

class ToggleButtonStyle : ButtonStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    super.paint(widget, g)

    ToggleButton btn := widget

    g.brush = brush
    x := btn.size.w / 2
    y := btn.size.h / 2
    if (btn.selected)
    {
      g.drawOval(x-8, y-8, 16, 16)
    }
    else
    {
      g.drawRect(x-6, y-6, 12, 12)
    }
  }
}