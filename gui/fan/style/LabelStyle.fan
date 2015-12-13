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
class LabelStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    Label lab := widget
    drawText(widget, g, lab.text, Align.begin)
  }
}