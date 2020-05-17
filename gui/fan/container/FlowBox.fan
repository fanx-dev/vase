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
@Serializable { collection = true }
class FlowBox : WidgetGroup
{
  Int spacing := 0

  override Void layoutChildren(Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    spacing := dpToPixel(this.spacing)

    lineHeight := 0
    this.each |Widget c, i|
    {
      size := c.bufferedPrefSize(hintsW, hintsH)
      if (x+size.w >= hintsW) {
        x = paddingLeft
        y += lineHeight + spacing
        lineHeight = 0
        c.setLayout(x, y, size.w, size.h, force)
      }
      else {
        c.setLayout(x, y, size.w, size.h, force)
      }
      x += size.w + spacing
      if (lineHeight < size.h) lineHeight = size.h
      //echo("$hintsW,  $x, $y, $size")
    }
  }
  
  protected override Size prefContentSize(Int hintsW := -1, Int hintsH := -1) {
    x := 0
    y := 0
    spacing := dpToPixel(this.spacing)

    lineHeight := 0
    this.each |Widget c, i|
    {
      size := c.bufferedPrefSize(hintsW, hintsH)
      if (x+size.w >= hintsW) {
        x = paddingLeft
        y += lineHeight + spacing
        lineHeight = 0
      }
      x += size.w + spacing
      if (lineHeight < size.h) lineHeight = size.h
      //echo("$x, $y, $lineHeight")
    }
    return Size(hintsW, y+lineHeight)
  }
}