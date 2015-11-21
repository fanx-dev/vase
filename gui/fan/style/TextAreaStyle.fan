//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
class TextAreaStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    TextArea area := widget
    g.font = area.font

    Int start := area.offsetY / area.rowHeight
    Int topOffset := area.offsetY - (start * area.rowHeight)
    Int end := ((area.offsetY+area.getContentHeight).toFloat/area.rowHeight).ceil.toInt
    if (end >= area.model.lineCount) {
      end = area.model.lineCount-1
    }
    Int fontOffset := area.font.ascent + area.font.leading

    Int selectionStartLine := -1
    Int selectionEndLine := -1
    Int selectionStartOffset := -1
    Int selectionEndOffset := -1
    Bool hasSelection := false
    //get selection
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
    Int x := -area.offsetX + area.padding.left
    Int y := -topOffset + area.padding.top
    Int bottomY := area.padding.top + area.getContentHeight
    for (i := start; i< area.model.lineCount; ++i)
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
      drawLineText(g, area.rowHeight, fontOffset, x, y, lineText, selStart, selEnd)
      
      y += area.rowHeight
      if (y > bottomY) {
        break
      }
    }

    //draw caret
    drawCaret(area, g, start, end)
  }

  private Void drawCaret(TextArea area, Graphics g, Int start, Int end) {
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
        Int x := area.font.width(line[0..<xOffset]) -area.offsetX
        g.drawLine(x, y, x, y + area.rowHeight)
      }
    }
  }

  protected virtual Void drawLineText(Graphics g, Int rowHeight, Int fontOffset
     , Int left, Int top, Str text, Int selStart, Int selEnd)
  {
    //backgound
    if (selStart >= 0 && selEnd >= 0)
    {
      g.brush = Color.makeRgb(200, 200, 200)
      selection := text[selStart..<selEnd]
      g.fillRect(g.font.width(text[0..<selStart])+left, top, g.font.width(selection), rowHeight)
    }

    //text
    g.brush = fontColor
    g.drawText(text, left, top+fontOffset)
  }
}