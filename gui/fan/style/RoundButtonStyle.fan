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
   Brush overColor := Color(0x6bd4fb)
   Brush outColor := Color(0x33b5e5)
   Brush downColor := Color(0x0099cc)

   new make()
   {
     fontColor = Color.white
   }

  override Void doPaint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget

    width := widget.width
    height := widget.height
    g.brush = outlineColor
    Int arc := height/2
    g.fillRoundRect(0, 0, width, height, arc, arc)


    offsetW := dpToPixel(8f)
    offsetR := dpToPixel(4f)
    width -= offsetW
    height -= offsetW
    arc = height/2
    if (btn.state == 0)
    {
      g.brush = overColor
    }
    else if (btn.state == 1)
    {
      g.brush = outColor
    }
    else if (btn.state == 2)
    {
      g.brush = downColor
    }

    g.fillRoundRect(offsetR, offsetR, width, height, arc, arc)

    drawText(widget, g, btn.text, Align.center)
  }
}