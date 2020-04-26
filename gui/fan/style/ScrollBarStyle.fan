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
class ScrollBarStyle : WidgetStyle
{
  Float barWidth := 8f

  new make()
  {
    background = Color(0xfafafa)
    foreground = Color(0x7c7c7c)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget

    if  (bar.isActive) {
      g.brush = background
      g.fillRect(0, 0, widget.width, widget.height)
      //g.alpha = 100
    }
    else {
      g.alpha = 100
    }
    g.brush = foreground
    Int pos := bar.screenPos
    Int thumb := bar.thumbSize
    top := widget.paddingTop
    left := widget.paddingLeft

    if (bar.vertical)
    {
      if  (bar.isActive)
        g.fillRect(left, top+pos, widget.contentWidth, thumb)
      else {
        barW := dpToPixel(barWidth)
        g.fillRect(left + widget.contentWidth - barW, top+pos, barW, thumb)
      }
      //echo("doPaint: $left, ${top+pos}, $widget.contentWidth, $thumb")
    }
    else
    {
      if  (bar.isActive)
        g.fillRect(left+pos, top, thumb, widget.contentHeight)
      else {
        barW := dpToPixel(barWidth)
        g.fillRect(left+pos, top+widget.contentHeight-barW, thumb, barW)
      }
    }
  }
}

@Js
class SliderBarStyle : WidgetStyle
{
  //Float size := (100f)
  Float width := (8f)

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

    Int cx := widget.contentWidth/2 + left
    Int cy := widget.contentHeight/2 + top

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