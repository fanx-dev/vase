//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** A display area for image
**
@Js
class ImageView : Widget
{
  ConstImage image

  new make(|This| f)
  {
    f(this)
  }

  protected override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| { 
        this.getRootView.layout
      }
      return result.set(0, 0)
    }
    s := image.size
    result.w = s.w
    result.h = s.h
    return result
  }
}