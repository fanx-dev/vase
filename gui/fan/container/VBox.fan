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
  Float spacing := 4f

  private Float getWeightSpace() {
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    Int spacing := dpToPixel(this.spacing)

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (c.layoutParam.height == LayoutParam.matchParent) {
        allWeight += c.layoutParam.weight
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
      
      if (c.layoutParam.height == LayoutParam.matchParent) {
        ch = (c.layoutParam.weight*weightSpace).toInt
      }
      y += ch + spacing
    
      c.layout(cx, cy, cw, ch, force)
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
      w = w.max(size.w)
      h += size.h
      if (i > 0) h += spacing
    }

    return Dimension(w, h)
  }
}