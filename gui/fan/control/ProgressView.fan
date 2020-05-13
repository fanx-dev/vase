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
  internal Int time := 0

  Float value := 0f {
    set {
      &value = it
      super.repaint
    }
  }

  new make() {
    //padding = Insets(20)
    //layout.width = Layout.wrapContent
  }
}
