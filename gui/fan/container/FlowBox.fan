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
  Float spacing := 0f

  override Void layoutChildren(Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    spacing := dpToPixel(this.spacing)

    this.each |Widget c|
    {
      size := c.bufferedPrefSize(hintsW, hintsH)
      cx := x
      cy := y

      cw := size.w
      ch := size.h
    
      c.setLayout(cx, cy, cw, ch, force)
      if (x >= hintsW) {
        x = paddingLeft
        y += ch + spacing
      }
      else {
        x += cw + spacing
      }
    }
  }

  protected override Dimension prefContentSize() {
    Int w := 0
    Int h := 0
    spacing := dpToPixel(this.spacing)
    this.each |c, i|
    {
      size := c.bufferedPrefSize()
      //echo("size$size")
      h = h.max(size.h)
      w += size.w
      if (i > 0) w += spacing
    }

    return Dimension(w, h)
  }
}