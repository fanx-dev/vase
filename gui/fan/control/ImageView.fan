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
  @Transient
  ConstImage? image

  Uri? uri

  new make(|This|? f := null)
  {
    layoutParam.widthType = SizeType.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      image = ConstImage(uri)
    }
  }

  protected override Dimension prefContentSize(Dimension result) {
    if (image == null) return result.set(0, 0)
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.requestLayout
      }
      return result.set(0, 0)
    }
    s := image.size
    result.w = dpToPixel(s.w.toFloat * 2)
    result.h = dpToPixel(s.h.toFloat * 2)
    return result
  }
}

@Js
class ImageButton : ButtonBase {
  @Transient
  ConstImage? image

  Uri? uri

  new make(|This|? f := null)
  {
    layoutParam.widthType = SizeType.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      image = ConstImage(uri)
    }
  }

  protected override Dimension prefContentSize(Dimension result) {
    if (image == null) return result.set(0, 0)
    if (!image.isReady) {
      Toolkit.cur.callLater(1000) |->| {
        this.getRootView.requestLayout
      }
      return result.set(0, 0)
    }
    s := image.size
    result.w = dpToPixel(s.w.toFloat * 2)
    result.h = dpToPixel(s.h.toFloat * 2)
    return result
  }

  protected override Void clicked() {
    a := TweenAnimation() {
      duration = 200
      //AlphaAnimChannel {},
      ScaleAnimChannel { from = 0.9f; to = 1.0f },
      //TransAnimChannel {  from = Point(-3, -3); to = Point(0, 0) },
    }
    a.run(this)
  }
}