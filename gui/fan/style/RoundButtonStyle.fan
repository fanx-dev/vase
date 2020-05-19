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
  Brush downColor := Color(0x0099cc)
  Int arc := 10

  new make(|This|? f := null)
  {
    fontColor = Color.white
    f?.call(this)
    c := color as Color
    if (c != null) {
      overColor = c.lighter
      downColor = c.darker
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


    // offsetW := dpToPixel(8)
    // offsetR := dpToPixel(4)
    // width -= offsetW
    // height -= offsetW
    offsetR := 0

    switch (btn.state) {
      case Button.mouseOver:
        g.brush = overColor
      case Button.mouseOut:
        g.brush = color
      case Button.mouseDown:
        g.brush = downColor
    }
    
    if (!btn.enabled) {
      g.brush = disableColor
    }

    g.fillRoundRect(offsetR, offsetR, width, height, arc, arc)

    drawText(widget, g, btn.text, btn.textAlign)
  }
}

/*
@Js
class ButtonBaseStyle : WidgetStyle
{
  Color[] colors

  new make()
  {
    colors =
    [
      Color.yellow,
      Color.orange,
      Color.green
    ]
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget
    if (btn.state < 3)
    {
      g.brush = colors[btn.state]
    }
    else
    {
      g.brush = background
    }

    g.fillRect(0, 0, widget.width, widget.height)

    drawText(widget, g, btn.text, btn.textAlign)
  }
}
*/