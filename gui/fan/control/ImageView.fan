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
  Image? image
  
  static const Int keepSize = 0
  static const Int stretch = 1
  static const Int fitWidth = 2
  static const Int fitHeight = 3
  Int scaleType = keepSize

  static const Int maskCircle := 1
  Int mask := 0

  Uri? uri
  
  Float imagePrefWidth := 240f
  Float imagePrefHeight := 240f

  //Dimension defSize := Dimension(0, 0)

  new make(|This|? f := null)
  {
    layoutParam.width = LayoutParam.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      image = Image.fromUri(uri)
    }
  }

  protected override Dimension prefContentSize() {
//    if (!image.isReady) {
//      Toolkit.cur.callLater(1000) |->| {
//        this.getRootView.relayout
//      }
//      return defSize
//    }
    
    w := dpToPixel(imagePrefWidth)
    h := dpToPixel(imagePrefHeight)
    return Dimension(w, h)
  }
}
