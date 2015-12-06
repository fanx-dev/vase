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
class ScrollBarStyle : WidgetStyle
{
  new make()
  {
    background = Color(0xfafafa)
    foreground = Color(0x7c7c7c)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget

    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)

    g.brush = foreground
    Int pos := bar.screenPos
    Int thumb := bar.thumbSize
    x := widget.padding.left
    y := widget.padding.top
    if (bar.vertical)
    {
      g.fillRect(x, y+pos, widget.contentWidth, thumb)
    }
    else
    {
      g.fillRect(x+pos, y, thumb, widget.contentHeight)
    }
  }
}

@Js
class SeekBarStyle : WidgetStyle
{
  Int size := dpToPixel(50f)
  Int width := dpToPixel(8f)

  new make()
  {
    outlineColor = Color(0x7c7c7c)
    foreground = Color(0x51d166)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget

    Int cx := widget.contentWidth/2 + widget.padding.top
    Int cy := widget.contentHeight/2 + widget.padding.left

    g.brush = outlineColor
    g.pen = Pen { it.width = this.width }

    if (bar.vertical) {
      g.drawLine(cx, widget.padding.top, cx, widget.padding.top + widget.contentHeight)
    } else {
      g.drawLine(widget.padding.left, cy, widget.padding.left + widget.contentWidth, cy)
    }

    g.brush = foreground
    Int pos := bar.screenPos
    Int r := size/2
    cx -= r
    cy -= r

    if (bar.vertical) {
      g.fillOval(cx, pos + widget.padding.top - r, size, size)
    } else {
      g.fillOval(pos + widget.padding.left - r, cy, size, size)
    }
  }
}