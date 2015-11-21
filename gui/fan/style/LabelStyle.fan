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
    g.brush = fontColor
    g.font = lab.font
    
    offset := lab.font.ascent + lab.font.leading
    g.drawText(lab.text, widget.padding.left, widget.padding.top+offset)
  }
}