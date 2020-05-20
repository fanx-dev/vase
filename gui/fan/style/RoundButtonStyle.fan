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
class RoundButtonStyle : WidgetStyle
{
  Brush overColor := Color(0x33b5e5)
  Int arc := 10

  new make(|This|? f := null)
  {
    fontColor = Color.white
    f?.call(this)
    c := color as Color
    if (c != null) {
      overColor = c.lighter
    }
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    width := widget.width
    height := widget.height
    
    Int arc := dpToPixel(this.arc)

    // g.brush = outlineColor
    // g.fillRoundRect(0, 0, width, height, arc, arc)

    offsetW := dpToPixel(8)
    offsetR := dpToPixel(4)
    width -= offsetW
    height -= offsetW
    
    if (btn.state == Button.mouseOver) {
        g.brush = overColor
    }
    else {
        g.brush = color
    }
    
    if (!btn.enabled) {
      g.brush = disableColor
    }

    g.fillRoundRect(offsetR, offsetR, width, height, arc, arc)
    
    
    if (btn.ripplePoint != null && btn.rippleSize > 0.0) {
        g.brush = rippleColor
        r := (btn.rippleSize * (100+btn.width)).toInt
        alpha := (256 * (1-btn.rippleSize)).toInt
        if (alpha > 200) alpha = 200
        g.alpha = alpha
        w := r+r
        g.fillOval(btn.ripplePoint.x-r, btn.ripplePoint.y-r, w, w)
        g.alpha = 255
    }

    drawText(widget, g, btn.text, btn.textAlign)
  }
}


@Js
class FlatButtonStyle : LabelStyle
{
  new make() {
    fontColor = color//Color(0x5577CC)
    fontInfo.bold = true
    background = Color(0xf2f2f2)
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget
    if (btn.ripplePoint != null && btn.rippleSize > 0.0) {
        g.brush = rippleColor
        r := (btn.rippleSize * (100+btn.width)).toInt
        alpha := (256 * (1-btn.rippleSize)).toInt
        if (alpha > 200) alpha = 200
        g.alpha = alpha
        w := r+r
        g.fillOval(btn.ripplePoint.x-r, btn.ripplePoint.y-r, w, w)
        g.alpha = 255
    }
    super.doPaint(widget, g)
  }
}
