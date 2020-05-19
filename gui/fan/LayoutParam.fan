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
    Float x := (parent * parentWidth) - (anchor * selfWidth) + w.dpToPixel(offsetX)
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
    Float y := (parent * parentHeight) - (anchor * selfHeight) + w.dpToPixel(offsetY)
    return y.toInt
  }

  Int prefWidth(Widget w, Int parentWidth, Int selfWidth) {
    if (width == matchParent) return parentWidth
    if (width == wrapContent) return selfWidth
    return w.dpToPixel(width)
  }

  Int prefHeight(Widget w, Int parentHeight, Int selfHeight) {
    if (height == matchParent) return parentHeight
    if (height == wrapContent) return selfHeight
    return w.dpToPixel(height)
  }

  ** Return hash of x and y.
  override Int hash() {
    Int hash := 17
    //hash = 31 * hash + widthType.hash
    //hash = 31 * hash + heightType.hash
    hash = 31 * hash + width.hash
    hash = 31 * hash + height.hash
    hash = 31 * hash + offsetX.hash
    hash = 31 * hash + offsetY.hash
    hash = 31 * hash + weight.hash
    return hash
  }

  ** Return if obj is same Point value.
  override Bool equals(Obj? obj)
  {
    that := obj as Layout
    if (that == null) return false
    return this.width == that.width
      && this.height == that.height
      && this.weight == that.weight
      && this.offsetX == that.offsetX
      && this.offsetY == that.offsetY
  }
}