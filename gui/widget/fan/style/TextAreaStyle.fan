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

    Int selectionStartLine := -1
    Int selectionEndLine := -1
    Int selectionStartOffset := -1
    Int selectionEndOffset := -1
    Bool hasSelection := false
    //draw selection
    if (area.selectionStart >= 0 && area.selectionEnd >= 0)
    {
      selectionStartLine = area.model.lineAtOffset(area.selectionStart)
      selectionEndLine = area.model.lineAtOffset(area.selectionEnd)
      selectionStartOffset = area.selectionStart - area.model.offsetAtLine(selectionStartLine)
      selectionEndOffset = area.selectionEnd - area.model.offsetAtLine(selectionEndLine)

      if (selectionStartLine > end || selectionEndLine < start)
      {
      }
      else
      {
        hasSelection = true
      }
    }

    //echo("$selectionStartLine, $selectionEndLine")

    //draw line
    Int selStart := -1
    Int selEnd := -1
    Int c := 0
    for (i := start; i< end; ++i)
    {
      lineText := area.model.line(i)
      if (hasSelection)
      {
        if (i == selectionStartLine)
        {
          selStart = selectionStartOffset
        }
        else if (i > selectionStartLine)
        {
          selStart = 0
        }
        else
        {
          selStart = -1
        }

        if (i == selectionEndLine)
        {
          selEnd = selectionEndOffset
        }
        else if (i < selectionEndLine)
        {
          selEnd = lineText.size
        }
        else
        {
          selEnd = -1
        }
      }
      //echo("- $selStart, $selEnd")
      drawLine(g, fontHeight, -area.offsetX, c * area.rowHeight, lineText, selStart, selEnd)
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

  protected virtual Void drawLine(Graphics g, Int fontHeight, Int offsetX, Int y, Str text, Int selStart, Int selEnd)
  {
    //backgound
    if (selStart >= 0 && selEnd >= 0)
    {
      g.brush = Color.makeRgb(200, 200, 200)
      selection := text[selStart..<selEnd]
      g.fillRect(g.font.width(text[0..<selStart])+offsetX, y, g.font.width(selection), fontHeight)
    }

    //text
    g.brush = brush
    g.drawText(text, offsetX, y+fontHeight)
  }
}