//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow


**
** Tell parent how to layout this widget
** The parent may ignore the param
**
@Js
class LayoutParam {

  **
  ** fill parent or others define by layout pane
  **
  static const Int matchParent := -1

  **
  ** preferred size by prefSize()
  **
  static const Int wrapContent := -2

  **
  ** out side bounder
  **
  Insets margin := Insets.defVal

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
  Float weight := 0f


  **
  ** align center horizontal or vertical
  **
  static const Int alignCenter := Int.minVal

  **
  ** align bootom or right
  **
  static const Int alignEnd := alignCenter-1

  **
  ** x position of widget.
  ** center for align center horizontal
  ** positive for left side. negative for right side
  **
  Int posX := 0

  **
  ** y position of widget.
  ** center for align center vertical
  ** positive for top side. negative for bottom side
  **
  Int posY := 0

}