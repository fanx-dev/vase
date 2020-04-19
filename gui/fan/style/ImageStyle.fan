//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class ImageStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    ImageView img := widget
    // if (!img.image.isReady) {
    //   return
    // }

    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft

    Size srcSize := img.image.size
    src := Rect(0, 0, srcSize.w, srcSize.h)
    dst := Rect(left,top,w,h)
//    echo("src$src,dst$dst")
    g.copyImage(img.image, src, dst)
  }
}
