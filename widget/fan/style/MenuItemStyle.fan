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
class MenuItemStyle : WidgetStyle
{
  new make()
  {
    background = Color.makeRgb(254, 255, 200)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    Button btn := widget

    //backgound
    g.brush = background
    g.fillRect(0, 0, widget.width, widget.height)
    //g.brush = brush
    //g.drawRect(0, 0, widget.size.w, widget.size.h)

    //draw text
    g.brush = brush
    g.font = btn.font
    y := widget.padding.top + (widget.getContentHeight / 2)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, widget.padding.left+1, y-(h/2f).toInt+offset)
  }
}