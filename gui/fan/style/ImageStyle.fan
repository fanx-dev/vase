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
    if (!img.image.isReady) {
       return
    }

    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft

    Size srcSize := img.image.size
    src1 := Rect(0, 0, srcSize.w, srcSize.h)
    mp := Coord(left.toFloat, top.toFloat)
    xp := Coord((left+w).toFloat, (top+h).toFloat)
    img.widgetToImg(mp)
    img.widgetToImg(xp)
    src2 := Rect(mp.x.toInt, mp.y.toInt, (xp.x-mp.x).toInt, (xp.y-mp.y).toInt)
    src := src1.intersection(src2)
    
    mp = Coord(src.x.toFloat, src.y.toFloat)
    xp = Coord((src.x+src.w).toFloat, (src.y+src.h).toFloat)
    img.imgToWidget(mp)
    img.imgToWidget(xp)
    dst := Rect(mp.x.toInt, mp.y.toInt, (xp.x-mp.x).toInt, (xp.y-mp.y).toInt)
//    echo("src$src,dst$dst")
    g.copyImage(img.image, src, dst)
  }
}
