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
class CheckBoxStyle : WidgetStyle
{
  new make() {
    //foreground = Color(0x51d166)
    background = Color.white
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget
    drawText(btn, g, btn.text, Align.begin)
    top := widget.paddingTop
    left := widget.paddingLeft

    size := btn.contentWidth.min(btn.contentHeight)
    r := size / 2
    x := left + (widget.contentWidth) - size
    y := top + (widget.contentHeight) - r
    r = (r*0.7f).toInt
    size = r + r

    //g.brush = this.background
    //g.fillRect(x-r, y-r, size, size)

    g.brush = this.outlineColor
    g.pen = Pen { width = dpToPixel(4) }
    g.drawRect(x-r, y-r, size, size)
    if (btn.selected)
    {
      r = (r * btn.animPostion).toInt
      g.pen = Pen { width = dpToPixel(6) }
      g.brush = this.color
      //g.drawLine(x-(r*0.6f).toInt, y-(r*0.15f).toInt, x, y+(r/2f).toInt)
      //g.drawLine(x+(r*1.1f).toInt, y-(r*1.1f).toInt, x, y+(r/2f).toInt)
      path := GraphicsPath()
      path.moveTo(x-(r*0.6f), y-(r*0.15f))
          .lineTo(x.toFloat, y+(r/2f))
          .lineTo(x+(r*1.05f), y-(r*1.05f))
      g.drawPath(path)
    }
  }
}

@Js
class RadioButtonStyle : WidgetStyle
{  
  new make() {
    //foreground = Color(0x51d166)
    background = Color.white
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget
    drawText(btn, g, btn.text, Align.begin)
    top := widget.paddingTop
    left := widget.paddingLeft

    size := btn.contentWidth.min(btn.contentHeight)
    r := size / 2
    x := left + (widget.contentWidth) - size
    y := top + (widget.contentHeight) - r
    r = (r*0.9f).toInt
    size = r + r

    g.brush = this.outlineColor
    g.fillOval(x-r, y-r, size, size)
    if (btn.selected)
    {
      cw := (r * 0.85 * btn.animPostion).toInt
      g.brush = this.color
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
    else {
      cw := (r * 0.85).toInt
      g.brush = this.background
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
  }
}

@Js
class SwitchStyle : WidgetStyle {
  Color buttonColor := Color.white
  
  new make() {
    //foreground = Color(0x51d166)
    background = outlineColor
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget
    drawText(btn, g, btn.text, Align.begin)

    top := widget.paddingTop
    left := widget.paddingLeft

    h := btn.contentHeight
    centerX := left + (widget.contentWidth) - h
    centerY := top + (widget.contentHeight) - (h/2)
    
    h = (h-dpToPixel(5)).toInt
    hw := (h*0.8).toInt
    w := hw+hw
    r := h/2

    g.brush = btn.selected ? this.color : background
    g.fillRoundRect(centerX-hw, centerY-r, w, h, r, r)
    //fillRundRect(g, centerX-hw, centerY-r, w, h)

    radius := r - dpToPixel(4)
    xOffset := ((w-r-r) * btn.animPostion).toInt

//    
    cx := centerX-hw+r+xOffset
    cy := centerY
//    drawCircle(g, cx, cy, radius
//        , buttonColor, outlineColor, outLinePen.width)
    g.brush = buttonColor
    g.fillOval(cx-radius, cy-radius, radius+radius, radius+radius)
  }
  
  /*
  private Void fillRundRect(Graphics g, Int x, Int y, Int w, Int h) {
    r := h / 2
    h = r + r
    g.fillRect(x+r, y, w-h, h)
    g.fillOval(x, y, h, h)
    g.fillOval(x+w-h, y, h, h)
  }
 
  private Void drawRoundRect(Graphics g, Int x, Int y, Int w, Int h
    , Color color, Brush outlineColor, Int outlineSize) {
    g.brush = outlineColor
    arc := h / 2
    g.fillRoundRect(x, y, w, h, arc, arc)
    
    g.brush = color
    arc = (h-outlineSize-outlineSize)/2
    g.fillRoundRect(x+outlineSize, y+outlineSize
        , w-outlineSize-outlineSize, h-outlineSize-outlineSize, arc, arc)
  }
  
  private Void drawCircle(Graphics g, Int cx, Int cy, Int radius
    , Color color, Color outlineColor, Int outlineSize) {
    g.brush = outlineColor
    g.fillOval(cx-radius, cy-radius, radius+radius, radius+radius)
    
    g.brush = color
    r := radius - outlineSize
    g.fillOval(cx-r, cy-r, r+r, r+r)
  }
  */
}