//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class Pane : WidgetGroup
{
  **
  ** Frame Layout
  **
  override Void layoutChildren(Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    this.each |Widget c|
    {
      if (!c.layout.ignore) {
        size := c.bufferedPrefSize(hintsW, hintsH)
        posX := c.layout.prefX(this, hintsW, size.w)
        posY := c.layout.prefY(this, hintsH, size.h)

        cx := x + posX
        cy := y + posY

        c.setLayout(cx, cy, size.w, size.h, force)
      }
    }
  }

  protected override Dimension prefContentSize() {
    Int maxX := 0
    Int maxY := 0
    this.each |c|
    {
      if (!c.layout.ignore) {
        size := c.bufferedPrefSize()
        x := size.w
        y := size.h

        offsetX := dpToPixel(c.layout.offsetX)
        offsetY := dpToPixel(c.layout.offsetY)
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
    return Dimension(maxX, maxY)
  }
}
