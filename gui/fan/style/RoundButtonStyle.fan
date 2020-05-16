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
   Int arc := 20

   new make()
   {
     fontColor = Color.white
   }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    width := widget.width
    height := widget.height
    g.brush = outlineColor
    Int arc := dpToPixel(this.arc)
    g.fillRoundRect(0, 0, width, height, arc, arc)


    offsetW := dpToPixel(8)
    offsetR := dpToPixel(4)
    width -= offsetW
    height -= offsetW
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

    drawText(widget, g, btn.text, btn.textAlign)
  }
}


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
