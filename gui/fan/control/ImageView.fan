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

  @Transient
  private Image? originImage
  
  Float imgScaleX := 1.0
  Float imgScaleY := 1.0
  Float imgOffsetX := 0.0
  Float imgOffsetY := 0.0
  
  static const Int keepSize = 0
  static const Int stretch = 1
  static const Int fitWidth = 2
  static const Int fitHeight = 3
  static const Int containIn = 4
  static const Int clipFill = 5

  Int scaleType = containIn

  static const Int maskCircle := 1
  Int mask := 0

  Uri? uri { set { &uri = it; loadImage } }
  
  // Int imagePrefWidth := 240
  // Int imagePrefHeight := 240

  private Bool isInited := false
  Void init(Bool force) {
    if (image == null) return
    if (!image.isReady) return
    if (isInited && !force) return
    isInited = true

    type := scaleType
    if (scaleType == containIn || scaleType == clipFill) {
      if (contentWidth/contentHeight.toFloat > image.size.w/image.size.h.toFloat) {
        if (scaleType == containIn) {
          type = fitHeight
        }
        else if (scaleType == clipFill) {
          type = fitWidth
        }
      }
      else {
        if (scaleType == containIn) {
          type = fitWidth
        }
        else if (scaleType == clipFill) {
          type = fitHeight
        }
      }
    }

    switch (type) {
    case keepSize: 
          imgScaleX = 1.0
          imgScaleY = 1.0
          imgOffsetX = 0.0
          imgOffsetY = 0.0
      
    case stretch: 
          imgOffsetX = 0.0
          imgOffsetY = 0.0
          imgScaleX = contentWidth / image.size.w.toFloat
          imgScaleY = contentHeight / image.size.h.toFloat
          //echo("width:$width, contentWidth:$contentWidth, size:$image.size")
      
    case fitWidth: 
          imgOffsetX = 0.0
          imgScaleX = contentWidth / image.size.w.toFloat
          imgScaleY = imgScaleX
          imgOffsetY = -(image.size.h * imgScaleX - contentHeight)/2
          //echo("$imgOffsetY, $imgScaleX")
      
    case fitHeight: 
          imgOffsetX = 0.0
          imgOffsetY = 0.0
          imgScaleY = contentHeight / image.size.h.toFloat
          imgScaleX = imgScaleY
          imgOffsetX = -(image.size.w * imgScaleY - contentWidth)/2
      
    default:
      throw ArgErr("unknow scaleType: $type")
    }
    
    if (mask == maskCircle) {
        if (originImage == null) originImage = image
        imgBuf := Image.make(originImage.size)
        g := imgBuf.graphics
        
        g.fillOval(0, 0, originImage.size.w, originImage.size.h)
        //g.composite = Composite.dstIn
        g.composite = Composite.srcIn
        g.drawImage(originImage, 0, 0)
        g.dispose
        image = imgBuf
    }
  }
  protected override Void layoutChildren(Bool force) { init(force) }
  
  Void imgToWidget(Coord p) {
    p.x = (p.x * imgScaleX) + imgOffsetX + paddingLeft
    p.y = (p.y * imgScaleY) + imgOffsetY + paddingTop
  }
  
  Void widgetToImg(Coord p) {
    p.x = (p.x - paddingLeft - imgOffsetX) / imgScaleX 
    p.y = (p.y - paddingTop - imgOffsetY) / imgScaleY
  }

  new make() {}

  private Void loadImage() {
    if (uri != null) {
      s := Unsafe<ImageView>(this)
      image = Image.fromUri(uri, null) {
        //echo("image loaded")
        isInited = false
        s.val.relayout
      }
    }
  }

  Void setDragable() {
    gestureFocusable = true
  }

  // protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
  //   w := dpToPixel(imagePrefWidth)
  //   h := dpToPixel(imagePrefHeight)
  //   return Size(w, h)
  // }
  
  protected override Void motionEvent(MotionEvent e)
  {
    super.motionEvent(e)
    if (!gestureFocusable) return
    if (e.consumed) return
    if (e.type == MotionEvent.wheel && e.delta != null) {
        scale := e.delta > 0 ? 0.8 : 1.25
        coord := Coord(e.x.toFloat, e.y.toFloat)
        mapToWidget(coord)
        zoom(coord, scale)
    }
  }
  
  protected Void zoom(Coord point, Float scale) {
    //echo("zoom:$point, $scale")
    pos := Coord(point.x, point.y)
    widgetToImg(pos)

    imgScaleX *= scale
    imgScaleY *= scale

    imgToWidget(pos)

    imgOffsetX -= pos.x - point.x
    imgOffsetY -= pos.y - point.y
    //echo("imgX:$imgX, xx:$xx, imgY:$imgY, yy:$yy")
    this.repaint
  }
  
  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    if (!gestureFocusable) return
    if (e.consumed) return
    if (e.type == GestureEvent.drag) {
      imgOffsetX += e.deltaX
      imgOffsetY += e.deltaY
      this.repaint
      //echo("imgScaleX:$imgScaleX, imgScaleY")
      e.consume
    }
    if (e.type == GestureEvent.multiTouch) {
        MultiTouchEvent me := e
        //echo("multiTouch:$e")
        coord := Coord(me.centerX, me.centerY)
        mapToWidget(coord)
        zoom(coord, me.scale)
        e.consume
    }
  }
}
