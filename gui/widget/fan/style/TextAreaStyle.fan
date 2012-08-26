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
class TextAreaStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    TextArea area := widget
    g.font = font
    g.push
    Rect r := Rect(0, 0, area.size.w-area.vbar.size.w, area.size.h-area.hbar.size.h)
    g.clip(r)

    Int start := area.offsetY / area.rowHeight
    Int count := area.size.h / area.rowHeight
    Int end := (start + count).min(area.model.lineCount)
    Int fontHeight := font.height

    Int c := 0
    for (i := start; i< end; ++i)
    {
      drawLine(g, -area.offsetX, fontHeight + c * area.rowHeight, area.model.line(i))
      ++c
    }

    if (area.caret.visible)
    {
      Int lineIndex := area.model.lineAtOffset(area.caret.offset)
      if (lineIndex < start || lineIndex > end)
      {
      }
      else
      {
        Int y := (lineIndex - start) * area.rowHeight
        Str line := area.model.line(lineIndex)
        Int xOffset := area.caret.offset - area.model.offsetAtLine(lineIndex)
        Int x := font.width(line[0..<xOffset]) -area.offsetX
        g.drawLine(x, y, x, y + area.caret.h)
      }
    }

    g.pop
  }

  protected virtual Void drawLine(Graphics g, Int x, Int y, Str text)
  {
    //backgound

    //text
    g.brush = brush
    g.drawText(text, x, y)
  }
}