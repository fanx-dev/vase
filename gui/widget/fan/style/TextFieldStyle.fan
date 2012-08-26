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
class TextFieldStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    TextField lab := widget

    g.brush = Color.makeRgb(200, 200, 200)
    g.fillRect(0, 0, widget.size.w, widget.size.h)

    g.brush = brush
    g.font = font
    g.drawText(lab.text, 0, widget.size.h-5)

    if (lab.caret.visible)
    {
      Int x := 1
      if (lab.text.size > 0)
      {
        x = font.width(lab.text[0..<lab.caret.offset])
      }
      g.drawLine(x, 0, x, 0 + lab.caret.h)
    }
  }
}