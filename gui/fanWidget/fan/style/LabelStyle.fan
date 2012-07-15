//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

class LabelStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    Label lab := widget
    g.brush = brush
    g.drawText(lab.text, 0, 20)
  }
}