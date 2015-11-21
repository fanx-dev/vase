//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using fanvasMath

@Js
mixin Style : DisplayMetrics
{
  abstract Void paint(Widget widget, Graphics g)
}

@Js
class WidgetStyle : Style
{
  Brush background := Color(0xf9f9f9)
  Brush foreground := Color(0x33b5e5)
  Brush outlineColor := Color(0xe9e9e9)
  Brush fontColor := Color(0x222222)

  ConstImage? backgroundImage


  final override Void paint(Widget widget, Graphics g)
  {
    //g.clip(Rect(0, 0, widget.width, widget.height))
    doPaint(widget, g)
  }

  virtual Void doPaint(Widget widget, Graphics g) {}
}