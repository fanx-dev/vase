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
class LabelStyle : WidgetStyle
{
  Bool fill := false

  override Void doPaint(Widget widget, Graphics g)
  {
    Label lab := widget
    if (fill) {
      width := widget.width
      height := widget.height
      g.brush = background
      g.fillRect(0, 0, width, height)
    }
    drawText(widget, g, lab.text, lab.textAlign)
  }
}

@Js
class ToastStyle : WidgetStyle {

  new make() {
    background = Color(0x434343)
    fontColor = Color.white
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Toast lab := widget

    width := widget.width
    height := widget.height
    g.brush = background
    Int arc := height/2
    g.fillRoundRect(0, 0, width, height, arc, arc)

    drawText(widget, g, lab.text, Align.center)
  }
}

@Js
class TextViewStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g)
  {
    TextView lab := widget
    lines := lab.wrapText
    
    x := widget.paddingLeft
    y := widget.paddingTop
    
    font := this.font(widget)
    offset := font.ascent + font.leading
    y += offset
    
    g.brush = fontColor
    g.font = font
    
    //echo("paint $lab.text $lines contentWidth:$lab.contentWidth")
    for (i:=0; i<lines.size; ++i) {
        s := lines[i]
        g.drawText(s, x, y)
        y += lab.rowHeight
    }
  }
}