//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
**
@Js
class ProgressView : Widget
{
  internal Float proVal := 0f

  new make() {
    padding = Insets(20)
    layoutParam.width = LayoutParam.wrapContent
    useRenderCache = false
  }

  protected override Void doPaint(Graphics g) {
    super.doPaint(g)
    repaint
  }
}