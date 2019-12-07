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
class MessageBoxStyle : WidgetStyle
{
  new make()
  {
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
  }
}