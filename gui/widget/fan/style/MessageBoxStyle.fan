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
class MessageBoxStyle : WidgetStyle
{
  new make()
  {
    bg = Color.makeRgb(200, 200, 200)
  }

  override Void paint(Widget widget, Graphics g)
  {
    g.brush = bg
    g.fillRect(0, 0, widget.size.w, widget.size.h)
  }
}