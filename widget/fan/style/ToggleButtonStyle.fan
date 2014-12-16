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
  protected Void drawText(ToggleButton btn, Graphics g) {
    g.brush = brush
    g.font = btn.font
    y := btn.padding.top + (btn.getContentHeight / 2)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, btn.padding.left+1, y-(h/2f).toInt+offset)
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget

    g.brush = brush
    size := btn.getContentWidth.min(btn.getContentHeight)
    r := size / 2
    x := widget.padding.left + (widget.getContentWidth) - r
    y := widget.padding.top + (widget.getContentHeight) - r
    r = (r*0.8f).toInt
    size = r + r
    
    g.drawRect(x-r, y-r, size, size)
    if (btn.selected)
    {
      g.drawLine(x-(r*0.8f).toInt, y-(r*0.7f).toInt, x, y+(r/2f).toInt)
      g.drawLine(x+(r*1.3f).toInt, y-(r*1.3f).toInt, x, y+(r/2f).toInt)
    }
    
    drawText(btn, g)
  }
}

@Js
class RadioButtonStyle : ToggleButtonStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    ToggleButton btn := widget

    g.brush = brush
    size := btn.getContentWidth.min(btn.getContentHeight)
    r := size / 2
    x := widget.padding.left + (widget.getContentWidth) - r
    y := widget.padding.top + (widget.getContentHeight) - r
    r = (r*0.8f).toInt
    size = r + r
    
    
    g.drawOval(x-r, y-r, size, size)
    if (btn.selected)
    {
      cw := (r*0.7f).toInt
      g.fillOval(x-(r/3f).toInt, y-(r/3f).toInt, cw, cw)
    }
    
    drawText(btn, g)
  }
}