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
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    //TODO
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