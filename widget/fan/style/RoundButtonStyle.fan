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


    offsetW := dpToPixel(16)
    offsetR := dpToPixel(8)
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


    //draw text
    g.brush = fontColor
    g.font = btn.font
    x := widget.padding.left + (widget.getContentWidth / 2)
    y := widget.padding.top + (widget.getContentHeight / 2)
    w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    offset += (btn.font.height - (btn.font.descent+btn.font.ascent + btn.font.leading))/2
    g.drawText(btn.text, x-(w/2f).toInt, y-(h/2f).toInt+offset)
  }
}