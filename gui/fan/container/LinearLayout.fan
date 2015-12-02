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
class LinearLayout : WidgetGroup
{
  Int spacing := 0

  Bool vertical := true

  override Void layoutChildren(Dimension result)
  {
    Int x := padding.left
    Int y := padding.top
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (vertical) {
        if (c.layoutParam.height == LayoutParam.matchParent) {
          allWeight += c.layoutParam.weight
        } else {
          size := c.canonicalPrefSize(hintsW, hintsH, result)
          spaceUsage += size.h
        }
        if (i > 0) spaceUsage += spacing
      }
      else {
        if (c.layoutParam.width == LayoutParam.matchParent) {
          allWeight += c.layoutParam.weight
        } else {
          size := c.canonicalPrefSize(hintsW, hintsH, result)
          spaceUsage += size.w
        }
        if (i > 0) spaceUsage += spacing
      }
    }

    Float weightSpace := 1f
    if (vertical) {
      if (hintsH > spaceUsage && allWeight>0f) {
        weightSpace = (hintsH - spaceUsage)/allWeight
      }
    }
    else {
      if (hintsW > spaceUsage && allWeight>0f) {
        weightSpace = (hintsW - spaceUsage)/allWeight
      }
    }


    this.each |Widget c|
    {
      size := c.canonicalPrefSize(hintsW, hintsH, result)
      left := c.layoutParam.margin.left
      top := c.layoutParam.margin.top
      cx := x + left
      cy := y + top
//      echo("pos$c.pos")

      cw := size.w
      ch := size.h
      if (vertical)
      {
        if (c.layoutParam.height == LayoutParam.matchParent) {
          ch = (c.layoutParam.weight*weightSpace).toInt
        }
        y += c.bufferedHeight + spacing
      }
      else
      {
        if (c.layoutParam.width == LayoutParam.matchParent) {
          cw = (c.layoutParam.weight*weightSpace).toInt
        }
        x += c.bufferedWidth + spacing
      }

      c.layout(cx, cy, cw, ch, result)
    }

//    echo("layoutY$y")

  }

  protected override Dimension prefContentSize(Dimension result) {
    Int w := 0
    Int h := 0
    this.each |c, i|
    {
      size := c.bufferedPrefSize(result)
      //echo("size$size")
      if (vertical)
      {
        w = w.max(size.w)
        h += size.h
        if (i > 0) h += spacing
      }
      else
      {
        h = h.max(size.h)
        w += size.w
        if (i > 0) w += spacing
      }
    }

//    echo("prefH$h")
    return result.set(w, h)
  }
}