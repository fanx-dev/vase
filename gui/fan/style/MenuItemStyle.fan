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
class MenuStyle : WidgetStyle {
  new make()
  {
    background = Color(0x434343)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
  }
}

@Js
class MenuItemStyle : WidgetStyle
{
  Color mouseOverColor := Color(0xb2b2b2)

  new make()
  {
    background = Color(0x434343)
    fontColor = Color.white
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    //backgound
    if (btn.state == Button.mouseOver) {
      g.brush = this.mouseOverColor
    } else {
      g.brush = background
    }

    g.fillRect(0, 0, widget.width, widget.height)

    drawText(widget, g, btn.text, Align.begin)
  }
}