//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using fgfxMath

@Js
mixin Style
{
  abstract Void paint(Widget widget, Graphics g)
}

@Js
class WidgetStyle : Style
{
  Brush background := Color.white//background
  Brush brush := Color.black

  ConstImage? backgroundImage

  Int? arc


  final override Void paint(Widget widget, Graphics g)
  {
    //g.clip(Rect(0, 0, widget.width, widget.height))
    doPaint(widget, g)
  }

  virtual Void doPaint(Widget widget, Graphics g) {}
}