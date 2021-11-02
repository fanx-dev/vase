//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
enum class Align {
  **
  ** align top or left
  **
  begin,
  **
  ** align center horizontal or vertical
  **
  center,
  **
  ** align bootom or right
  **
  end
}

**
** Tell parent how to layout this widget
** The parent may ignore the param
**
@Js
@Serializable
virtual class Layout {

  **
  ** fill parent or others define by layout pane
  **
  static const Int matchParent := 0
  
  **
  ** preferred size by prefSize()
  **
  static const Int wrapContent := -1

  ** Percent unit constant
  const static Str percent := "%"


  Bool ignored := false

  **
  ** width of widget
  **
  Int width := matchParent

  **
  ** height of widget
  **
  Int height := wrapContent

  **
  ** layout weight compare to sibling widget
  **
  Float weight := 1.0f

  **
  ** x position of widget.
  **
  Int offsetX := 0

  **
  ** y position of widget.
  **
  Int offsetY := 0

  **
  ** vertical Alignment
  **
  Align vAlign := Align.begin

  **
  ** horizontal Alignment
  **
  Align hAlign := Align.begin
  
  **
  ** the unit is percent of parent
  **
  Str wUnit := ""
  Str hUnit := ""
  Str xUnit := ""
  Str yUnit := ""

  private Int getPixel(Widget w, Int val, Str unit, Int parentSize, Int selfSize) {
    if (unit.size == 0) {
      return w.dpToPixel(val)
    }
    else if (unit == percent) {
      return (val/100f*parentSize).toInt
    }
    throw ArgErr("Unknow unit: $unit")
  }
  
  Int prefX(Widget w, Int parentWidth, Int selfWidth) {
    Float parent := 0.0f
    Float anchor := 0.0f
    if (hAlign == Align.center) {
        parent = 0.5f
        anchor = 0.5f
    }
    else if (hAlign == Align.end) {
        parent = 1.0f
        anchor = 1.0f
    }
    offset := getPixel(w, offsetX, xUnit, parentWidth, selfWidth)
    Float x := (parent * parentWidth) - (anchor * selfWidth) + offset
    return x.toInt
  }

  Int prefY(Widget w, Int parentHeight, Int selfHeight) {
    Float parent := 0.0f
    Float anchor := 0.0f
    if (vAlign == Align.center) {
        parent = 0.5f
        anchor = 0.5f
    }
    else if (vAlign == Align.end) {
        parent = 1.0f
        anchor = 1.0f
    }
    offset := getPixel(w, offsetY, yUnit, parentHeight, selfHeight)
    Float y := (parent * parentHeight) - (anchor * selfHeight) + offset
    return y.toInt
  }

  Int prefWidth(Widget w, Int parentWidth, Int selfWidth) {
    if (width == matchParent) return parentWidth
    if (width == wrapContent) return selfWidth
    return getPixel(w, width, wUnit, parentWidth, selfWidth)
  }

  Int prefHeight(Widget w, Int parentHeight, Int selfHeight) {
    if (height == matchParent) return parentHeight
    if (height == wrapContent) return selfHeight
    prefH := getPixel(w, height, hUnit, parentHeight, selfHeight)
    return prefH.toInt
  }

}