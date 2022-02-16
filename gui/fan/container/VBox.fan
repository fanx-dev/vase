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
class VBox : WidgetGroup
{
  Int spacing := 4

  private Float getWeightSpace() {
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    Int spacing := dpToPixel(this.spacing)

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (c.layout.height == Layout.matchParent) {
        allWeight += c.layout.weight
      } else {
        size := c.bufferedPrefSize(-1, -1)
        spaceUsage += size.h
      }
      if (i > 0) spaceUsage += spacing      
    }

    Float weightSpace := 1f
  
    if (hintsH > spaceUsage && allWeight>0f) {
      weightSpace = (hintsH - spaceUsage)/allWeight
    }
    
    return weightSpace
  }

  override Void layoutChildren(Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    spacing := dpToPixel(this.spacing)
    Float weightSpace := getWeightSpace()

    this.each |Widget c|
    {
      size := c.bufferedPrefSize(hintsW, hintsH)
      cx := x
      cy := y

      cw := size.w
      ch := size.h
      
      if (c.layout.height == Layout.matchParent) {
        ch = (c.layout.weight*weightSpace).toInt
      }
      y += ch + spacing
      cx += c.layout.prefX(this, hintsW, hintsH, size.w)
    
      c.setLayout(cx, cy, cw, ch, force)
    }
  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    Int w := 0
    Int h := 0
    spacing := dpToPixel(this.spacing)
    this.each |c, i|
    {
      size := c.bufferedPrefSize(hintsWidth, hintsHeight)
      //echo("size$size")
      w = w.max(size.w)
      h += size.h
      if (i > 0) h += spacing
    }

    return Size(w, h)
  }
}