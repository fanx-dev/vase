//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

class TextFieldStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    TextField lab := widget

    g.brush = Color.makeRgb(200, 200, 200)
    g.fillRect(0, 0, widget.size.w, widget.size.h)

    g.brush = brush
    g.drawText(lab.text, 0, widget.size.h-5)
  }
}