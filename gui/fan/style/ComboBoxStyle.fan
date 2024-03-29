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
class ComboBoxStyle : WidgetStyle {

  new make()
  {
    outlineColor = Color(0x7f7f7f)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    g.brush = outlineColor
    lWidth := dpToPixel(lineWidth)
    g.pen = Pen { it.width = lWidth }

    top := widget.paddingTop
    left := widget.paddingLeft
    bottom := top + widget.contentHeight
    right :=  left + widget.contentWidth

    g.drawLine(left, bottom, right-1, bottom)

    cornerSize := (font(widget).height * 0.6f).toInt
    pa := PointArray(3)
    pa.setX(0, right-cornerSize)
    pa.setY(0, bottom)
    pa.setX(1, right)
    pa.setY(1, bottom)
    pa.setX(2, right)
    pa.setY(2, bottom-cornerSize)
    g.fillPolygon(pa)

    //draw text
    drawText(widget, g, btn.text, btn.textAlign)
  }
}
