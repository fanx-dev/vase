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
  ConstImage? image

  new make(|This|? f := null)
  {
    layoutParam.widthType = SizeType.wrapContent
    if (f != null) f(this)
  }

  protected override Dimension prefContentSize(Dimension result) {
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.requestLayout
      }
      return result.set(0, 0)
    }
    s := image.size
    result.w = dpToPixel(s.w.toFloat * 4)
    result.h = dpToPixel(s.h.toFloat * 4)
    return result
  }
}