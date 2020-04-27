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
    //TODO
  }

  protected override Dimension prefContentSize() {
    Int w := 0
    Int h := 0
    this.each |c, i|
    {
      size := c.bufferedPrefSize(-1, -1)
    }

    return Dimension(w, h)
  }
}