//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
class ImageStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {
    ImageView img := widget
    if (!img.image.isReady) {
      return
    }

    Int w := widget.getContentWidth
    Int h := widget.getContentHeight
    x := widget.padding.left
    y := widget.padding.top

    Size srcSize := img.image.size
    src := Rect(0, 0, srcSize.w, srcSize.h)
    dst := Rect(x,y,w,h)
//    echo("src$src,dst$dst")
    g.copyImage(img.image, src, dst)
  }
}