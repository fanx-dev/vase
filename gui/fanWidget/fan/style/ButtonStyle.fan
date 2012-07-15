//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

class ButtonStyle : WidgetStyle
{

  WidgetStyle[] stateStyle

  new make()
  {
    stateStyle =
    [
      WidgetStyle { it.bg = Color.green },
      WidgetStyle { it.bg = Color.red },
      WidgetStyle { it.bg = Color.yellow }
    ]
  }

  override Void paint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget
    if (btn.state < 3)
    {
      stateStyle[btn.state].paint(widget, g)
    }
    else
    {
      g.brush = bg
      g.fillRect(0, 0, widget.size.w, widget.size.h)
      g.brush = Color.red
    }
  }
}