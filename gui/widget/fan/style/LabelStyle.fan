//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

class LabelStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    Label lab := widget
    g.brush = brush
    g.drawText(lab.text, 0, 20)
  }
}