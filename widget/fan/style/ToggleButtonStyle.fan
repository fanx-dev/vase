//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

@Js
class ToggleButtonStyle : WidgetStyle
{
  new make() {
    foreground = Color(0x51d166)
  }
  
  protected Void drawText(ToggleButton btn, Graphics g) {
    g.brush = fontColor
    g.font = btn.font
    y := btn.padding.top + (btn.getContentHeight / 2)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, btn.padding.left+1, y-(h/2f).toInt+offset)
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget

    size := btn.getContentWidth.min(btn.getContentHeight)
    r := size / 2
    x := widget.padding.left + (widget.getContentWidth) - size
    y := widget.padding.top + (widget.getContentHeight) - r
    r = (r*0.7f).toInt
    size = r + r
    
    g.brush = this.outlineColor
    pen := Pen { width = btn.dpToPixel(8) }
    g.pen = pen
    g.drawRect(x-r, y-r, size, size)
    if (btn.selected)
    {
      pen2 := Pen { width = btn.dpToPixel(15) }
      g.pen = pen2
      g.brush = this.foreground
      g.drawLine(x-(r*0.6f).toInt, y-(r*0.15f).toInt, x, y+(r/2f).toInt)
      g.drawLine(x+(r*1.1f).toInt, y-(r*1.1f).toInt, x, y+(r/2f).toInt)
    }
    
    drawText(btn, g)
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

    size := btn.getContentWidth.min(btn.getContentHeight)
    r := size / 2
    x := widget.padding.left + (widget.getContentWidth) - size
    y := widget.padding.top + (widget.getContentHeight) - r
    r = (r*0.9f).toInt
    size = r + r
    
    g.brush = this.outlineColor
    g.fillOval(x-r, y-r, size, size)
    if (btn.selected)
    {
      g.brush = this.foreground
      cw := (r*0.7f).toInt
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
    else {
      g.brush = this.buttonColor
      cw := (r*0.7f).toInt
      g.fillOval(x-cw, y-cw, cw+cw, cw+cw)
    }
    
    drawText(btn, g)
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
    Switch btn := widget

    size := btn.getContentHeight*2
    r := btn.getContentHeight
    centerX := widget.padding.left + (widget.getContentWidth) - r
    centerY := widget.padding.top + (widget.getContentHeight) - (r/2)
    r = (r*0.9f).toInt
    size = r + r
    
    widthR := (r * 0.8f).toInt
    heightR := r/2
    
    g.brush = outlineColor
    g.fillRoundRect(centerX-widthR, centerY-heightR
        , widthR+widthR, heightR+heightR, heightR, heightR)
    
//    echo("centerX$centerX, widthR$widthR")
    
    widthR = (widthR * 0.9f).toInt
    heightR = (heightR * 0.9f).toInt
    if (btn.selected) {
      g.brush = this.foreground
    } else {
      g.brush = this.buttonColor
    }
    g.fillRoundRect(centerX-widthR, centerY-heightR
        , widthR+widthR, heightR+heightR, heightR, heightR)
    
    
    xOffset := ((widthR+widthR-heightR-heightR) * btn.animPostion).toInt
    height := heightR+heightR
    g.brush = buttonColor
    g.fillOval(centerX-widthR+xOffset, centerY-heightR, height, height)
    
    pen := Pen { width = btn.dpToPixel(10) }
    g.pen = pen
    g.brush = outlineColor
    g.drawOval(centerX-widthR+xOffset, centerY-heightR, height, height)
    
    drawText(btn, g)
  }
}