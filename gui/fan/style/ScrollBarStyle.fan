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
  Int barWidth := 8

  new make()
  {
    background = Color(0xfafafa)
    color = Color(0x7c7c7c)
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
    g.brush = color
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
  Int width := 8
  Brush buttonColor := Color.white

  new make()
  {
    //outlineColor = Color(0x7c7c7c)
    //foreground = Color(0x51d166)
    outlineColor = Color(0xd0d0d0)
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
      g.brush = color
      pos := bar.screenPos
      g.drawLine(cx, top, cx, top + pos)
    } else {
      g.drawLine(left, cy, left + widget.contentWidth, cy)
      g.brush = color
      pos := bar.screenPos
      g.drawLine(left, cy, left + pos, cy)
    }

    g.brush = buttonColor
    Int pos := bar.screenPos
    Int r := size/2
    cx -= r
    cy -= r
    circleX := cx
    circleY := cy
    if (bar.vertical) {
        circleY = pos + top - r
    }
    else {
        circleX = pos + left - r
    }
    
    g.brush = outlineColor
    g.fillOval(circleX, circleY, size, size)
    g.brush = buttonColor
    stroke := dpToPixel(lineWidth)
    csize := size - stroke - stroke
    g.fillOval(circleX+stroke, circleY+stroke, csize, csize)    
  }
}