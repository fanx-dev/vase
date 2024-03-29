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
@Serializable
mixin Style
{
  abstract Void paint(Widget widget, Graphics g)
  abstract Font font(Widget widget)
}

@Js
class FontInfo {
    Int size := 33
    Str name := "SansSerif"
    Bool bold := false
    Bool italic := false
    
    new make(|This|? f := null) { f?.call(this) }
}

@Js
class WidgetStyle : Style
{
  Brush background := Color(0xf9f9f9)
  Brush color := Color(0x33b5e5)
  Brush outlineColor := Color(0xe9e9e9)
  Brush fontColor := Color(0x222222)
  Brush disableColor := Color(0xb0b0b0)
  Brush rippleColor := Color(0x999999)
  Int fontStrokeType := 0

  Image? backgroundImage
  Uri? backgroundImageUri { set { &backgroundImageUri = it; loadImage } }
  Int lineWidth := 2

  FontInfo fontInfo := FontInfo()
  @Transient private Font? pixelFont
  @Transient private Int fontCacheSize
  
  override Font font(Widget widget) {
     fontSize := widget.dpToPixel(fontInfo.size)
     if (pixelFont != null) {
        if (fontSize != fontCacheSize) {
            pixelFont = null
        }
     }
     if (pixelFont == null) {
        pixelFont = Font(fontSize, fontInfo.name, fontInfo.bold, fontInfo.italic)
        fontCacheSize = fontSize
     }
     return pixelFont
  }

  private Void loadImage() {
    if (backgroundImage == null && backgroundImageUri != null) {
      backgroundImage = Image.fromUri(backgroundImageUri, null) {}
    }
  }

  final override Void paint(Widget widget, Graphics g)
  {
    //g.clip(Rect(0, 0, widget.width, widget.height))
    doPaint(widget, g)
  }

  virtual Void doPaint(Widget widget, Graphics g) {}

  protected Int dpToPixel(Int dp) {
    DisplayMetrics.cur.dpToPixel(dp.toFloat)
  }

  protected Void drawText(Widget widget, Graphics g, Str text, Align align, Align vAlign := Align.center) {
    if (text.size == 0) return
    
    top := widget.paddingTop
    left := widget.paddingLeft
    //draw text
    g.brush = fontColor
    font := this.font(widget)
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
      x = left + dpToPixel(2)
    }
    else if (align == Align.center) {
      w := font.width(text)
      x = left + (widget.contentWidth / 2) - (w/2f).toInt
    }
    else if (align == Align.end) {
      w := font.width(text)
      x = left + (widget.contentWidth) - w.toInt
    }

    if (fontStrokeType == 1) {
      g.lineWidth = dpToPixel(lineWidth).toFloat
      g.brush = outlineColor
      g.drawTextOutline(text, x, y)
      
      g.brush = fontColor
      g.drawText(text, x, y)
    }
    else if (fontStrokeType == 2) {
      g.lineWidth = dpToPixel(lineWidth).toFloat
      g.brush = outlineColor
      g.drawTextOutline(text, x, y)
    }
    else {
      g.drawText(text, x, y)
    }
  }
}