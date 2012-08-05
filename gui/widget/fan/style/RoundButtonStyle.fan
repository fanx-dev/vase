//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
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

  override Void paint(Widget widget, Graphics g)
  {
    Button btn := widget
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

    g.fillRoundRect(0, 0, widget.size.w-1, widget.size.h-1, arc, arc)

    g.brush = Color.black
    g.drawRoundRect(0, 0, widget.size.w-1, widget.size.h-1, arc, arc)


    //draw text
    g.brush = brush
    g.font = font
    x := btn.size.w / 2
    y := btn.size.h / 2
    w := font.width(btn.text)
    h := font.height
    g.drawText(btn.text, x-(w/2f).toInt, y+(h/2f).toInt-2)
  }
}