//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
**
@Js
class ProgressView : Widget
{
  new make() {
    padding = Insets(50)
    layoutParam.widthType = SizeType.wrapContent
  }
}