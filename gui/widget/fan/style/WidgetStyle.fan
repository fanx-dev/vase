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
mixin Style
{
  abstract Void paint(Widget widget, Graphics g)
}

@Js
class WidgetStyle : Style
{
  Brush bg := Color.white//background
  Brush brush := Color.black
  //Border
  Font font := Font("Courier New", 12)
  Int? arc

  override Void paint(Widget widget, Graphics g)
  {
  }
}