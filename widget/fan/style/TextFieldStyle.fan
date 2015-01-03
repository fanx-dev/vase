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
class TextFieldStyle : WidgetStyle
{
  Color hintColor := Color(0xd7d7d7)

  new make() {
    outlineColor = Color(0x858585)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    TextField lab := widget

    g.brush = outlineColor

    left := 1
    bottom := widget.padding.top + widget.getContentHeight-1
    right := widget.width - 1

    g.drawLine(left, bottom, right-1, bottom)
    upSize := (lab.font.height * 0.3f).toInt
    g.drawLine(left, bottom, left, bottom-upSize)
    g.drawLine(right-1, bottom, right-1, bottom-upSize)


    g.font = lab.font
    offset := lab.font.ascent + lab.font.leading
    x := widget.padding.left
    y := widget.padding.top

    if (!lab.text.isEmpty) {
      g.brush = fontColor
      str := lab.text
      if (lab.password) {
        buf := StrBuf()
        str.size.times{
          buf.add("*")
        }
        str = buf.toStr
      }
      g.drawText(str, x, y+offset)
    }
    else if (!lab.hint.isEmpty) {
      g.brush = hintColor
      g.drawText(lab.hint, x+2, y+offset)
    }

    if (lab.caret.visible)
    {
      Int xOffset := 1
      if (lab.text.size > 0)
      {
        xOffset = lab.font.width(lab.text[0..<lab.caret.offset])
      }
      g.drawLine(x+xOffset, y, x+xOffset, y+lab.font.height)
    }
  }
}