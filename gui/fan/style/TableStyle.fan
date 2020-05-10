//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class TableHeaderStyle : WidgetStyle
{
  new make()
  {
    background = Color.makeRgb(254, 255, 200)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    //backgound
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
    g.brush = foreground
    g.drawRect(0, 0, widget.width, widget.height)

    drawText(widget, g, btn.text, Align.center)
  }
}

@Js
class TableStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    Table tab := widget
    top := widget.paddingTop
    left := widget.paddingLeft
    g.font = font
    Int rowHeight := dpToPixel(tab.rowHeight)

    // get num of cols
    Int numCols := tab.model.numCols
    Int fontOffset := font.ascent + font.leading
    bottomLine := top+tab.contentHeight
    rightLine := left+tab.contentWidth

    Int start := tab.offsetY / rowHeight
    Int topOffset := tab.offsetY - (start * rowHeight)

    Int y := -topOffset + rowHeight + top
    for (i := start; i< tab.model.numRows; ++i)
    {
      if (i >= 0) {
        Int x := -tab.offsetX + left
        for (j := 0; j<numCols; ++j)
        {
          Str text := tab.model.text(j, i)
          drawCell(g, x, y, tab.colWidthCache[j], rowHeight, text, fontOffset)
          x += tab.colWidthCache[j]
          if (x > rightLine) {
            break
          }
        }
      }

      y += rowHeight
      if (y > bottomLine) {
        break
      }
    }
  }

  protected virtual Void drawCell(Graphics g, Int x, Int y, Int w, Int h, Str text, Int fontOffset)
  {
    //backgound
    g.brush = background
    g.fillRect(x, y, w, h)
    g.brush = foreground
    g.drawRect(x, y, w, h)

    //text
    g.brush = fontColor
    g.drawText(text, x+1, y+fontOffset)
  }
}