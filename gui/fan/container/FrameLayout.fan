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
class Pane : WidgetGroup
{
  **
  ** Frame Layout
  **
  override Void layoutChildren(Dimension result, Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    this.each |Widget c|
    {
      if (!c.layoutParam.ignore) {
        size := c.canonicalSize(hintsW, hintsH, result)
        posX := c.layoutParam.prefX(this, hintsW, size.w)
        posY := c.layoutParam.prefY(this, hintsH, size.h)

        cx := x + posX
        cy := y + posY

        c.layout(cx, cy, size.w, size.h, result, force)
      }
    }
  }

  protected override Dimension prefContentSize(Dimension result) {
    Int maxX := 0
    Int maxY := 0
    this.each |c|
    {
      if (!c.layoutParam.ignore) {
        size := c.bufferedPrefSize(result)
        x := size.w
        y := size.h

        offsetX := dpToPixel(c.layoutParam.posX.offset)
        offsetY := dpToPixel(c.layoutParam.posY.offset)
        if (offsetX > 0) {
          x += offsetX
        }
        if (offsetY >0) {
          y += offsetY
        }

        if (maxX < x) maxX = x
        if (maxY < y) maxY = y
      }
    }

    //echo("$maxX, $maxY")
    return result.set(maxX, maxY)
  }
}

@Js
@Serializable { collection = true }
class FrameLayout : Pane {
}