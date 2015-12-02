//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow


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
    ButtonBase btn := widget

    //backgound
    if (btn.state == ButtonBase.mouseOver) {
      g.brush = this.mouseOverColor
    } else {
      g.brush = background
    }
    
    g.fillRect(0, 0, widget.width, widget.height)
    //g.brush = brush
    //g.drawRect(0, 0, widget.size.w, widget.size.h)

    //draw text
    g.brush = fontColor
    g.font = btn.font
    y := widget.padding.top + (widget.contentHeight / 2)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, widget.padding.left+1, y-(h/2f).toInt+offset)
  }
}