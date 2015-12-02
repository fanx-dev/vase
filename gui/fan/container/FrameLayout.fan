//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
class FrameLayout : WidgetGroup
{
  **
  ** Frame Layout
  **
  override Void layoutChildren(Dimension result)
  {
    Int x := padding.left
    Int y := padding.top
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    this.each |Widget c|
    {
      size := c.canonicalPrefSize(hintsW, hintsH, result)
      left := c.layoutParam.margin.left
      top := c.layoutParam.margin.top
      posX := c.layoutParam.posX
      posY := c.layoutParam.posY

      if (posX == LayoutParam.alignCenter) {
        posX = (hintsW - c.bufferedWidth) / 2
      }
      else if (posX == LayoutParam.alignEnd) {
        posX = hintsW
      }

      if (posY == LayoutParam.alignCenter) {
        posY = (hintsH - c.bufferedHeight) / 2
      }
      else if (posY == LayoutParam.alignEnd) {
        posY = hintsH
      }

      cx := x + left + posX
      cy := y + top + posY
      c.layout(cx, cy, size.w, size.h, result)
    }
  }

  protected override Dimension prefContentSize(Dimension result) {
    Int maxX := 0
    Int maxY := 0
    this.each |c|
    {
      size := c.bufferedPrefSize(result)
      x := size.w
      y := size.h

      offsetX := c.layoutParam.posX
      offsetY := c.layoutParam.posY
      if (offsetX != LayoutParam.alignCenter && offsetX != LayoutParam.alignEnd) {
        x += offsetX
      }
      if (offsetY != LayoutParam.alignCenter && offsetY != LayoutParam.alignEnd) {
        y += offsetY
      }
      if (maxX < x) maxX = x
      if (maxY < y) maxY = y
    }
    return result.set(maxX, maxY)
  }
}