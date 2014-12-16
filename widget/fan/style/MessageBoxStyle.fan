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
class MessageBoxStyle : WidgetStyle
{
  new make()
  {
    background = Color.makeRgb(200, 200, 200)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
  }
}