//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

mixin Style
{
  abstract Void paint(Widget widget, Graphics g)
}

class WidgetStyle : Style
{
  Brush bg := Color.white//background
  Brush brush := Color.black
  //Border
  Font? font
  Int? arc

  override Void paint(Widget widget, Graphics g)
  {
    g.brush = bg
    g.fillRect(0, 0, widget.size.w, widget.size.h)
  }
}