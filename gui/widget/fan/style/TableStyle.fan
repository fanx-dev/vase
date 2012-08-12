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
class TableHeaderStyle : WidgetStyle
{
  new make()
  {
    bg = Color.makeRgb(254, 255, 200)
  }

  override Void paint(Widget widget, Graphics g)
  {
    Button btn := widget

    //backgound
    g.brush = bg
    g.fillRect(0, 0, widget.size.w, widget.size.h)
    g.brush = brush
    g.drawRect(0, 0, widget.size.w, widget.size.h)

    //draw text
    g.brush = brush
    g.font = font
    y := btn.size.h / 2
    h := font.height
    g.drawText(btn.text, 15, y+(h/2f).toInt-2)
  }
}

@Js
class TableStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    Table tab := widget
    g.font = font
    g.push
    Rect r := Rect(0, tab.headerHeight, tab.size.w-tab.vbar.size.w, tab.size.h-tab.headerHeight-tab.hbar.size.h)
    g.clip(r)

    // get num of cols
    Int numCols := tab.model.numCols

    // get num of rows
    Int numRows := 0
    Int h := 0
    for (i := 0; i<tab.model.numRows; ++i)
    {
      if (h < tab.size.h - tab.headerHeight - tab.hbar.size.h)
      {
        h += tab.rowHeight
        numRows++
      }
      else
      {
        break
      }
    }

    //draw
    Int y := tab.headerHeight
    Int fontHeight := font.height
    for (i := 0; i<numRows; ++i)
    {
      Int x := -tab.offsetX
      for (j := 0; j<numCols; ++j)
      {
        row := i+(tab.offsetY.toFloat / tab.rowHeight).ceil.toInt
        if (row >= tab.model.numRows) break
        Str text := tab.model.text(j, row)
        drawCell(g, x, y, tab.colWidthBuf[j], tab.rowHeight, text, fontHeight)
        x += tab.colWidthBuf[j]
      }
      y += tab.rowHeight
    }

    g.pop
  }

  protected virtual Void drawCell(Graphics g, Int x, Int y, Int w, Int h, Str text, Int fontHeight)
  {
    //backgound
    g.brush = bg
    g.fillRect(x, y, w, h)
    g.brush = brush
    g.drawRect(x, y, w, h)

    //text
    g.brush = brush
    g.drawText(text, x+1, y+fontHeight)
  }
}