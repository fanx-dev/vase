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

    width := dpToPixel(8)
    g.brush = color
    g.pen = Pen { it.width = width }
    
    elapsed := 0
    if (p.time == 0) {
        p.time = TimePoint.nowMillis
    }
    else {
        elapsed = TimePoint.nowMillis - p.time
        if (elapsed < 0) elapsed = 0
    }

    t := (elapsed / 3)

    start := t * 1
    end := t * 2

    sweep := end - start
    if (sweep < 0) {
        start = end
        sweep = -sweep
    }
    if (sweep > 360) {
        sweep = sweep % 360
    }

    s := (w.min(h) - width - width).toInt
    cx := w/2-s/2
    cy := h/2-s/2
    g.drawArc(top+cx, left+cy, s, s, start, sweep)

    p.repaint
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
    g.brush = color
    g.fillRect(x, y, w2, h)
  }
}