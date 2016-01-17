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
    top := widget.paddingTop
    left := widget.paddingLeft

    if (bar.vertical)
    {
      g.fillRect(left, top+pos, widget.contentWidth, thumb)
      //echo("doPaint: $left, ${top+pos}, $widget.contentWidth, $thumb")
    }
    else
    {
      g.fillRect(left+pos, top, thumb, widget.contentHeight)
    }
  }
}

@Js
class SliderBarStyle : WidgetStyle
{
  //Float size := (100f)
  Float width := (16f)

  new make()
  {
    outlineColor = Color(0x7c7c7c)
    foreground = Color(0x51d166)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget
    top := widget.paddingTop
    left := widget.paddingLeft

    Int cx := widget.contentWidth/2 + top
    Int cy := widget.contentHeight/2 + left

    width := dpToPixel(this.width)
    size := widget.contentHeight

    g.brush = outlineColor
    g.pen = Pen { it.width = width }

    if (bar.vertical) {
      g.drawLine(cx, top, cx, top + widget.contentHeight)
    } else {
      g.drawLine(left, cy, left + widget.contentWidth, cy)
    }

    g.brush = foreground
    Int pos := bar.screenPos
    Int r := size/2
    cx -= r
    cy -= r

    if (bar.vertical) {
      g.fillOval(cx, pos + top - r, size, size)
    } else {
      g.fillOval(pos + left - r, cy, size, size)
    }
  }
}