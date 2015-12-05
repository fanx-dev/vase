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
class FlowLayout : WidgetGroup
{
  Int spacing := 0

  override Void layoutChildren(Dimension result, Bool force)
  {
    Int x := padding.left
    Int y := padding.top
    Int hintsW := contentWidth
    Int hintsH := contentHeight

    Int spaceUsage := 0
    Float allWeight := 0f

    Int rowHeight := 0

    this.each |c, i| {
      if (c.layoutParam.width == LayoutParam.matchParent) {
        x = padding.left

      } else {

      }

      if (c.layoutParam.height != LayoutParam.matchParent) {
        if (c.layoutParam.height > rowHeight) {
          rowHeight = c.layoutParam.height
        }
        y += rowHeight + spacing
      }
    }

  }

  protected override Dimension prefContentSize(Dimension result) {
    Int w := 0
    Int h := 0
    this.each |c, i|
    {
      size := c.bufferedPrefSize(result)
    }

    return result.set(w, h)
  }
}