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

  override Void doLayout(Dimension result)
  {
    Int x := padding.left
    Int y := padding.top
    Int hintsW := getContentWidth
    Int hintsH := getContentHeight

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (vertical) {
        if (c.layoutParam.height == LayoutParam.matchParent) {
          allWeight += c.layoutParam.weight
        } else {
          size := c.prefBufferedSize(hintsW, hintsH, result)
          spaceUsage += size.h
        }
        if (i > 0) spaceUsage += spacing
      }
      else {
        if (c.layoutParam.width == LayoutParam.matchParent) {
          allWeight += c.layoutParam.weight
        } else {
          size := c.prefBufferedSize(hintsW, hintsH, result)
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
      size := c.measureSize(hintsW, hintsH, result)
      left := c.layoutParam.margin.left
      top := c.layoutParam.margin.top
      c.x = x + left
      c.y = y + top
//      echo("pos$c.pos")

      if (vertical)
      {
        if (c.layoutParam.height == LayoutParam.matchParent) {
          c.width = size.w
          c.height = (c.layoutParam.weight*weightSpace).toInt
        } else {
          c.width = size.w
          c.height = size.h
        }
        y += c.getBufferedHeight + spacing
      }
      else
      {
        if (c.layoutParam.width == LayoutParam.matchParent) {
          c.width = (c.layoutParam.weight*weightSpace).toInt
          c.height = size.h
        } else {
          c.width = size.w
          c.height = size.h
        }
        x += c.getBufferedWidth + spacing
      }

      c.doLayout(result)
    }

//    echo("layoutY$y")

  }

  protected override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    Int w := 0
    Int h := 0
    this.each |c, i|
    {
      size := c.prefBufferedSize(hintsWidth, hintsHeight, result)
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