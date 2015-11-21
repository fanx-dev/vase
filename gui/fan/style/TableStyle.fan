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
class TableHeaderStyle : WidgetStyle
{
  new make()
  {
    background = Color.makeRgb(254, 255, 200)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget

    //backgound
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
    g.brush = foreground
    g.drawRect(0, 0, widget.width, widget.height)

    //draw text
    g.brush = fontColor
    g.font = btn.font
    x := widget.padding.left + (widget.getContentWidth / 2)
    y := widget.padding.top + (widget.getContentHeight / 2)
    w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, x-(w/2f).toInt, y-(h/2f).toInt+offset)
  }
}

@Js
class TableStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    Table tab := widget
    g.font = tab.font

    // get num of cols
    Int numCols := tab.model.numCols
    Int fontOffset := tab.font.ascent + tab.font.leading
    bottomLine := tab.padding.top+tab.getContentHeight
    rightLine := tab.padding.left+tab.getContentWidth

    Int start := tab.offsetY / tab.rowHeight
    Int topOffset := tab.offsetY - (start * tab.rowHeight)

    Int y := -topOffset + tab.headerHeight + widget.padding.top
    for (i := start; i< tab.model.numRows; ++i)
    {
      Int x := -tab.offsetX + widget.padding.left
      for (j := 0; j<numCols; ++j)
      {
        Str text := tab.model.text(j, i)
        drawCell(g, x, y, tab.colWidthCache[j], tab.rowHeight, text, fontOffset)
        x += tab.colWidthCache[j]
        if (x > rightLine) {
          break
        }
      }

      y += tab.rowHeight
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