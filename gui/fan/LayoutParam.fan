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

**
** Tell parent how to layout this widget
** The parent may ignore the param
**
@Js
@Serializable
class LayoutParam {
  **
  ** out side bounder
  **
  Insets margin := Insets.defVal

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

  Align hAlign := Align.begin
  Align vAlign := Align.begin

  **
  ** x position of widget.
  **
  Float posX := 0f

  **
  ** y position of widget.
  **
  Float posY := 0f

  Int prefX(Widget w, Int parentWidth, Int selfWidth) {
    switch (hAlign) {
      case Align.center:
        return (parentWidth - selfWidth) / 2
      case Align.end:
        return (parentWidth - selfWidth) - w.dpToPixel(posX)
      case Align.begin:
        return w.dpToPixel(posX)
      default:
        return w.dpToPixel(posX)
    }
  }

  Int prefY(Widget w, Int parentHeight, Int selfHeight) {
    switch (vAlign) {
      case Align.center:
        return (parentHeight - selfHeight) / 2
      case Align.end:
        return (parentHeight - selfHeight) - w.dpToPixel(posY)
      case Align.begin:
        return w.dpToPixel(posY)
      default:
        return w.dpToPixel(posY)
    }
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
}