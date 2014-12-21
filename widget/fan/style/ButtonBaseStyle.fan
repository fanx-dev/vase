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
class ComboBoxStyle : WidgetStyle {
  Color[] colors

  new make()
  {
    //over/out/down
    colors =
    [
      Color(0xd9dedf),
      Color(0xffffff),
      Color(0xcccccc)
    ]
    
    outlineColor = Color(0x7f7f7f)
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    ButtonBase btn := widget
    if (btn.state < 3)
    {
      g.brush = colors[btn.state]
    }
    else
    {
      g.brush = background
    }

    g.fillRect(0, 0, widget.width, widget.height)
    
    g.brush = outlineColor
    bottom := widget.padding.top + widget.getContentHeight
    right := widget.padding.left + widget.getContentWidth
//    pen := Pen { width = btn.dpToPixel(8) }
//    g.pen = pen
    g.drawLine(widget.padding.left, bottom, right-1, bottom)
    
    cornerSize := (btn.font.height * 0.6f).toInt
//    path := Path()
//    path.moveTo(right-cornerSize, bottom)
//        .moveTo(right, bottom)
//        .moveTo(right, bottom-cornerSize).close
    pa := PointArray(3)
    pa.setX(0, right-cornerSize)
    pa.setY(0, bottom)
    pa.setX(1, right)
    pa.setY(1, bottom)
    pa.setX(2, right)
    pa.setY(2, bottom-cornerSize)
    g.fillPolygon(pa)
    

    //draw text
    g.brush = fontColor
    g.font = btn.font
    x := widget.padding.left
    y := widget.padding.top + (widget.getContentHeight / 2)
    //w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, x, y-(h/2f).toInt+offset)
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
    ButtonBase btn := widget
    if (btn.state < 3)
    {
      g.brush = colors[btn.state]
    }
    else
    {
      g.brush = background
    }

    g.fillRect(0, 0, widget.width, widget.height)

    //draw text
    g.brush = fontColor
    g.font = btn.font
    x := widget.padding.left + (widget.getContentWidth / 2)
    y := widget.padding.top + (widget.getContentHeight / 2)
    w := btn.font.width(btn.text)
    h := btn.font.height
    offset := btn.font.ascent + btn.font.leading
    g.drawText(btn.text, x-(w/2f).toInt, y-(h/2f).toInt+offset)
  }
}