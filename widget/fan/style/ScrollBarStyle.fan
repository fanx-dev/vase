//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

@Js
class ScrollBarStyle : WidgetStyle
{
  new make()
  {
    background = Color.gray
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget

    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)

    g.brush = brush
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