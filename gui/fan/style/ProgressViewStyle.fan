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
class ProgressViewStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g) {
    p := widget
    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft

    width := dpToPixel(30f)
    g.brush = outlineColor
    g.pen = Pen { it.width = width }

    for (i:=0; i<360; i+=30) {
      g.drawArc(top, left, w, h, i, 5)
    }
  }
}