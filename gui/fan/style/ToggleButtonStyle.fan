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
class ToggleButtonStyle : WidgetStyle
{
  Pen outLinePen := Pen { width = dpToPixel(3f) }
  Pen contectPen := Pen { width = dpToPixel(8f) }

  new make() {
    foreground = Color(0x51d166)
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

    g.brush = this.background
    g.fillRect(x-r, y-r, size, size)

    g.brush = this.outlineColor
    g.pen = outLinePen
    g.drawRect(x-r, y-r, size, size)
    if (btn.selected)
    {
      r = (r * btn.animPostion).toInt
      g.pen = contectPen
      g.brush = this.foreground
      //g.drawLine(x-(r*0.6f).toInt, y-(r*0.15f).toInt, x, y+(r/2f).toInt)
      //g.drawLine(x+(r*1.1f).toInt, y-(r*1.1f).toInt, x, y+(r/2f).toInt)
      path := Path()
      path.moveTo(x-(r*0.6f), y-(r*0.15f))
          .lineTo(x.toFloat, y+(r/2f))
          .lineTo(x+(r*1.05f), y-(r*1.05f))
      g.drawPath(path)
    }
  }
}

@Js
class RadioButtonStyle : ToggleButtonStyle
{
  Brush buttonColor := Color.white

  new make() {
    foreground = Color(0x51d166)
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
      g.brush = this.foreground
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
    else {
      cw := (r * 0.85).toInt
      g.brush = this.buttonColor
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
  }
}

@Js
class SwitchStyle : ToggleButtonStyle {
  Brush buttonColor := Color.white

  new make() {
    foreground = Color(0x51d166)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget
    drawText(btn, g, btn.text, Align.begin)

    top := widget.paddingTop
    left := widget.paddingLeft

    size := btn.contentHeight*2
    r := btn.contentHeight
    centerX := left + (widget.contentWidth) - r
    centerY := top + (widget.contentHeight) - (r/2)
    r = (r*0.9f).toInt
    size = r + r

    widthHalf := (r * 0.8f).toInt
    heightHalf := r/2

    g.brush = outlineColor
    g.fillRoundRect(centerX-widthHalf, centerY-heightHalf
        , widthHalf+widthHalf, heightHalf+heightHalf, heightHalf, heightHalf)

//    echo("centerX$centerX, widthR$widthR")
    widthR := (widthHalf - outLinePen.width).toInt
    heightR := (heightHalf - outLinePen.width).toInt
    if (btn.selected) {
      g.brush = this.foreground
    } else {
      g.brush = this.buttonColor
    }
    g.fillRoundRect(centerX-widthR, centerY-heightR
        , widthR+widthR, heightR+heightR, heightR, heightR)


    xOffset := ((widthR+widthR-heightR-heightR) * btn.animPostion).toInt
    height := heightR+heightR
    g.brush = outlineColor
    g.fillOval(centerX-widthHalf+xOffset, centerY-heightHalf, heightHalf+heightHalf, heightHalf+heightHalf)

    //g.pen = outLinePen
    g.brush = buttonColor
    //g.drawOval(centerX-widthR+xOffset, centerY-heightR, height, height)
    g.fillOval(centerX-widthR+xOffset, centerY-heightR, height, height)

  }
}