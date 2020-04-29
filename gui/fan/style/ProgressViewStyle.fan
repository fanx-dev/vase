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
class ProgressViewStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g) {
    ProgressView p := widget
    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft

    width := dpToPixel(10f)
    g.brush = outlineColor
    g.pen = Pen { it.width = width }

    s := w.min(h)
    Int i := p.value.toInt
    step := 60
    for (; i<=360; i+=step) {
      g.drawArc(top, left, s, s, i, 15)
    }

    p.value += 1.0
    if (p.value > step.toFloat) {
      p.value -= step.toFloat
    }
  }
}

@Js
class ProgressBarStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g) {
    ProgressView p := widget
    Int w := widget.contentWidth
    Int h := widget.contentHeight
    x := widget.paddingTop
    y := widget.paddingLeft

    g.brush = background
    g.fillRect(x, y, w, h)
    
    w2 := (w * p.value).toInt
    g.brush = foreground
    g.fillRect(x, y, w2, h)
  }
}