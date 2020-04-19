//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using vaseMath

@Js
mixin Style
{
  abstract Void paint(Widget widget, Graphics g)
  abstract Font font()
}

@Js
class WidgetStyle : Style
{
  Brush background := Color(0xf9f9f9)
  Brush foreground := Color(0x33b5e5)
  Brush outlineColor := Color(0xe9e9e9)
  Brush fontColor := Color(0x222222)
  Brush selectedColor := Color(0x8888f9)

  Image? backgroundImage
  Float lineWidth := 2f

  private Bool fontSizeInit := false
  override Font font := Font(35) {
    get {
      if (!fontSizeInit) {
        &font = &font.toSize(dpToPixel(&font.size.toFloat))
        fontSizeInit = true
      }
      return &font
    }
  }

  final override Void paint(Widget widget, Graphics g)
  {
    //g.clip(Rect(0, 0, widget.width, widget.height))
    doPaint(widget, g)
  }

  virtual Void doPaint(Widget widget, Graphics g) {}

  protected Int dpToPixel(Float dp) {
    DisplayMetrics.dpToPixel(dp)
  }

  protected Void drawText(Widget widget, Graphics g, Str text, Align align, Align vAlign := Align.center) {
    top := widget.paddingTop
    left := widget.paddingLeft
    //draw text
    g.brush = fontColor
    g.font = font

    offset := font.ascent + font.leading
    y := top
    if (vAlign == Align.begin) {
      y = top + offset
    }
    else if (vAlign == Align.center) {
      y = top + (widget.contentHeight / 2) - (font.height/2f).toInt + offset
    }
    else if (vAlign == Align.end) {
      y = top + (widget.contentHeight) - (font.height).toInt + offset
    }

    x := left
    if (align == Align.begin) {
      x = left + dpToPixel(2f)
    }
    else if (align == Align.center) {
      w := font.width(text)
      x = left + (widget.contentWidth / 2) - (w/2f).toInt
    }
    else if (align == Align.end) {
      w := font.width(text)
      x = left + (widget.contentWidth) - (w/2f).toInt
    }

    g.drawText(text, x, y)
  }
}