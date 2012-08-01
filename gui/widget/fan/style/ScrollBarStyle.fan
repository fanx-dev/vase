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
class ScrollBarStyle : WidgetStyle
{

  new make()
  {
    bg = Color.gray
  }

  override Void paint(Widget widget, Graphics g)
  {
    ScrollBar bar := widget

    g.brush = bg
    g.fillRect(0, 0, widget.size.w, widget.size.h)

    g.brush = brush
    Int pos := bar.toViewCoord(bar.startPos)
    if (bar.orientationV)
    {
      Int thumb := bar.toViewCoord(widget.size.h)
      g.fillRect(0, pos, widget.size.w, thumb)
    }
    else
    {
      Int thumb := bar.toViewCoord(widget.size.w)
      g.fillRect(pos, 0, thumb, widget.size.h)
    }
  }
}