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
** A display area for image
**
@Js
class ImageView : Widget
{
  @Transient
  ConstImage? image

  Uri? uri

  Dimension defSize := Dimension(0, 0)

  new make(|This|? f := null)
  {
    layoutParam.widthType = SizeType.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      image = ConstImage(uri)
    }
  }

  protected override Dimension prefContentSize() {
    if (image == null) return defSize
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.relayout
      }
      return defSize
    }
    s := image.size
    w := dpToPixel(s.w.toFloat)
    h := dpToPixel(s.h.toFloat)
    return Dimension(w, h)
  }
}

@Js
class ImageButton : ButtonBase {
  @Transient
  ConstImage? image

  Uri? uri

  Dimension defSize := Dimension(0, 0)

  new make(|This|? f := null)
  {
    layoutParam.widthType = SizeType.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      image = ConstImage(uri)
    }
  }

  protected override Dimension prefContentSize() {
    if (image == null) return defSize
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.relayout
      }
      return defSize
    }
    s := image.size
    w := dpToPixel(s.w.toFloat)
    h := dpToPixel(s.h.toFloat)
    return Dimension(w, h)
  }

  protected override Void clicked() {
    this.scaleAnim(0.9).start
  }
}