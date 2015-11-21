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
      g.fillRect(x, y+pos, widget.getContentWidth, thumb)
    }
    else
    {
      g.fillRect(x+pos, y, thumb, widget.getContentHeight)
    }
  }
}