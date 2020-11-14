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
    if (img.image == null) return
    if (!img.image.isReady) {
       return
    }

    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft


    Size srcSize := img.image.size
    mp := Coord(0.0, 0.0)
    xp := Coord(srcSize.w.toFloat, srcSize.h.toFloat)
    img.imgToWidget(mp)
    img.imgToWidget(xp)
    projSrc := Rect(mp.x.toInt, mp.y.toInt, (xp.x-mp.x).toInt, (xp.y-mp.y).toInt)
    dstRec := Rect(left, top, w, h)
    dst := projSrc.intersection(dstRec)
    
    mp.set(left.toFloat, top.toFloat)
    xp.set((left+w).toFloat, (top+h).toFloat)
    img.widgetToImg(mp)
    img.widgetToImg(xp)
    projDst := Rect(mp.x.toInt, mp.y.toInt, (xp.x-mp.x).toInt, (xp.y-mp.y).toInt)
    srcRec := Rect(0, 0, srcSize.w, srcSize.h)
    src := projDst.intersection(srcRec)

    g.copyImage(img.image, src, dst)
  }
}
