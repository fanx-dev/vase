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
** A display area for image
**
@Js
class ImageView : Widget
{
  ConstImage image

  new make(|This| f)
  {
    layoutParam.widthType = SizeType.wrapContent
    f(this)
  }

  protected override Dimension prefContentSize(Dimension result) {
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.requestLayout
      }
      return result.set(0, 0)
    }
    s := image.size
    result.w = s.w
    result.h = s.h
    return result
  }
}