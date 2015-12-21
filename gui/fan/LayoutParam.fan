//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

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

@Js
@Serializable
class LayoutPosition {
  Float parent := 0f
  Float anchor := 0f
  Float offset := 0f

  ** Return hash of x and y.
  override Int hash() { parent.hash.xor(anchor.hash.shiftl(16)).xor(offset.hash.shiftl(31)) }

  ** Return if obj is same Point value.
  override Bool equals(Obj? obj)
  {
    that := obj as LayoutPosition
    if (that == null) return false
    return this.parent == that.parent && this.anchor == that.anchor && this.offset == that.offset
  }

  ** Return '"x,y"'
  override Str toStr() { "$parent,$anchor,$offset" }
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
  LayoutPosition posX := LayoutPosition()

  **
  ** y position of widget.
  **
  LayoutPosition posY := LayoutPosition()

  Int prefX(Widget w, Int parentWidth, Int selfWidth) {
    Float x := (posX.parent * parentWidth) + (posX.anchor * selfWidth) + w.dpToPixel(posX.offset)
    return x.toInt
  }

  Int prefY(Widget w, Int parentHeight, Int selfHeight) {
    Float y:= (posY.parent * parentHeight) + (posY.anchor * selfHeight) + w.dpToPixel(posY.offset)
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
    hash = 31 * hash + posX.hash
    hash = 31 * hash + posY.hash
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
      && this.posX == that.posX
      && this.posY == that.posY
  }
}