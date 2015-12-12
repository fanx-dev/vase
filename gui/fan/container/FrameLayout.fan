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
  override Void layoutChildren(Dimension result, Bool force)
  {
    Int x := padding.left
    Int y := padding.top
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    this.each |Widget c|
    {
      size := c.canonicalSize(hintsW, hintsH, result)
      posX := c.layoutParam.prefX(hintsW, size.w)
      posY := c.layoutParam.prefY(hintsH, size.h)

      cx := x + posX
      cy := y + posY

      c.layout(cx, cy, size.w, size.h, result, force)
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
      if (offsetX > 0) {
        x += offsetX
      }
      if (offsetY >0) {
        y += offsetY
      }

      if (maxX < x) maxX = x
      if (maxY < y) maxY = y
    }

    //echo("$maxX, $maxY")
    return result.set(maxX, maxY)
  }
}