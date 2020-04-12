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

@Js
enum class SizeType {
  **
  ** fill parent or others define by layout pane
  **
  matchParent,
  **
  ** preferred size by prefSize()
  **
  wrapContent,

  fixed,

  percent
}

**
** Tell parent how to layout this widget
** The parent may ignore the param
**
@Js
@Serializable
class LayoutParam {

  SizeType widthType := SizeType.matchParent
  SizeType heightType := SizeType.wrapContent

  Bool ignore := false

  **
  ** width of widget
  **
  Float widthVal := 0f

  **
  ** height of widget
  **
  Float heightVal := 0f

  **
  ** layout weight compare to sibling widget
  **
  Float weight := 1.0f

  **
  ** x position of widget.
  **
  Float offsetX := 0.0f

  **
  ** y position of widget.
  **
  Float offsetY := 0.0f

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
    switch (widthType) {
      case SizeType.matchParent:
        return parentWidth
      case SizeType.wrapContent:
        return selfWidth
      case SizeType.percent:
        return (parentWidth * widthVal / 100).toInt
      case SizeType.fixed:
        return w.dpToPixel(widthVal)
      default:
        return w.dpToPixel(widthVal)
    }
  }

  Int prefHeight(Widget w, Int parentHeight, Int selfHeight) {
    switch (heightType) {
      case SizeType.matchParent:
        return parentHeight
      case SizeType.wrapContent:
        return selfHeight
      case SizeType.percent:
        return (parentHeight * heightVal / 100).toInt
      case SizeType.fixed:
        return w.dpToPixel(heightVal)
      default:
        return w.dpToPixel(heightVal)
    }
  }

  ** Return hash of x and y.
  override Int hash() {
    Int hash := 17
    hash = 31 * hash + widthType.hash
    hash = 31 * hash + heightType.hash
    hash = 31 * hash + widthVal.hash
    hash = 31 * hash + heightVal.hash
    hash = 31 * hash + offsetX.hash
    hash = 31 * hash + offsetY.hash
    hash = 31 * hash + weight.hash
    return hash
  }

  ** Return if obj is same Point value.
  override Bool equals(Obj? obj)
  {
    that := obj as LayoutParam
    if (that == null) return false
    return this.widthType == that.widthType
      && this.heightType == that.heightType
      && this.widthVal == that.widthVal
      && this.heightVal == that.heightVal
      && this.weight == that.weight
      && this.offsetX == that.offsetX
      && this.offsetY == that.offsetY
  }
}