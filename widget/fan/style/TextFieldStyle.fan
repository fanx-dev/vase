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
class TextFieldStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    TextField lab := widget

    g.brush = Color.makeRgb(200, 200, 200)
    g.fillRect(0, 0, widget.width, widget.height)

    g.brush = brush
    g.font = lab.font
    offset := lab.font.ascent + lab.font.leading
    x := widget.padding.left
    y := widget.padding.top
    g.drawText(lab.text, x, y+offset)

    if (lab.caret.visible)
    {
      Int xOffset := 1
      if (lab.text.size > 0)
      {
        xOffset = lab.font.width(lab.text[0..<lab.caret.offset])
      }
      g.drawLine(x+xOffset, y, x+xOffset, y+lab.font.height)
    }
  }
}