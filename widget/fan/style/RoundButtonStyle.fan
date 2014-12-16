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
   Brush overColor := Color.red
   Brush outColor := Color.yellow
   Brush downColor := Color.green

   new make()
   {
     arc = 10
   }

  override Void doPaint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget
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

    g.fillRoundRect(0, 0, widget.width-1, widget.height-1, arc, arc)

    g.brush = Color.black
    g.drawRoundRect(0, 0, widget.width-1, widget.height-1, arc, arc)


    //draw text
    g.brush = brush
    g.font = btn.font
    x := widget.padding.left + (widget.getContentWidth / 2)
    y := widget.padding.top + (widget.getContentHeight / 2)
    w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, x-(w/2f).toInt, y-(h/2f).toInt+offset)
  }
}