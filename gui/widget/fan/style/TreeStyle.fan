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
class TreeStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    Button btn := widget
    TreeNode node := btn.parent

    //draw text
    g.brush = brush
    g.font = font
    y := btn.size.h / 2
    h := font.height
    g.drawText(btn.text, 15, y+(h/2f).toInt-2)
    g.drawLine(2, 0, 2, btn.size.h)
    g.drawLine(2, y, 10, y)
  }
}