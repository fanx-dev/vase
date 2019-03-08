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
@Serializable { collection = true }
class VBox : WidgetGroup
{
  Float spacing := 4f

  private Float getWeightSpace(Dimension result) {
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    Int spacing := dpToPixel(this.spacing)

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (c.layoutParam.heightType == SizeType.matchParent) {
        allWeight += c.layoutParam.weight
      } else {
        size := c.bufferedPrefSize(result)
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

  override Void layoutChildren(Dimension result, Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    spacing := dpToPixel(this.spacing)
    Float weightSpace := getWeightSpace(result)

    this.each |Widget c|
    {
      size := c.canonicalSize(hintsW, hintsH, result)
      cx := x
      cy := y

      cw := size.w
      ch := size.h
      
      if (c.layoutParam.heightType == SizeType.matchParent) {
        ch = (c.layoutParam.weight*weightSpace).toInt
      }
      y += ch + spacing
    
      c.layout(cx, cy, cw, ch, result, force)
    }
  }

  protected override Dimension prefContentSize(Dimension result) {
    Int w := 0
    Int h := 0
    spacing := dpToPixel(this.spacing)
    this.each |c, i|
    {
      size := c.bufferedPrefSize(result)
      //echo("size$size")
      w = w.max(size.w)
      h += size.h
      if (i > 0) h += spacing
    }

    return result.set(w, h)
  }
}