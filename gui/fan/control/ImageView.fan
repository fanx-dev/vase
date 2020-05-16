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
  
  Float imgScaleX := 1.0
  Float imgScaleY := 1.0
  Float imgOffsetX := 0.0
  Float imgOffsetY := 0.0
  
  static const Int keepSize = 0
  static const Int stretch = 1
  static const Int fitWidth = 2
  static const Int fitHeight = 3
  Int scaleType = fitWidth

  static const Int maskCircle := 1
  Int mask := 0

  Uri? uri
  
  Int imagePrefWidth := 240
  Int imagePrefHeight := 240

  Bool isInited := false
  protected Void init() {
    if (!image.isReady) return
    if (isInited) return
    isInited = true
    
    if (scaleType == keepSize) {
        imgScaleX = 1.0
        imgScaleY = 1.0
        imgOffsetX = 0.0
        imgOffsetY = 0.0
    }
    else if (scaleType == stretch) {
        imgOffsetX = 0.0
        imgOffsetY = 0.0
        imgScaleX = contentWidth / image.size.w.toFloat
        imgScaleY = contentHeight / image.size.h.toFloat
        echo("width:$width, contentWidth:$contentWidth, size:$image.size")
    }
    else if (scaleType == fitWidth) {
        imgOffsetX = 0.0
        imgScaleX = contentWidth / image.size.w.toFloat
        imgScaleY = imgScaleX
        imgPreH := contentHeight / imgScaleX
        imgOffsetY = (imgPreH - image.size.h.toFloat)/2
    }
    else if (scaleType == fitHeight) {
        imgOffsetX = 0.0
        imgOffsetY = 0.0
        imgScaleY = contentHeight / image.size.h.toFloat
        imgScaleX = imgScaleY
        imgPreW := contentWidth / imgScaleY
        imgOffsetX = (imgPreW - image.size.w.toFloat)/2
    }
    
    if (mask == maskCircle) {
        imgBuf := Image.make(image.size)
        g := imgBuf.graphics
        
        g.fillOval(0, 0, image.size.w, image.size.h)
        //g.composite = Composite.dstIn
        g.composite = Composite.srcIn
        g.drawImage(image, 0, 0)
        
        image = imgBuf
    }
  }
  protected override Void layoutChildren(Bool force) { init }
  
  Void imgToWidget(Coord p) {
    p.x = (p.x + imgOffsetX) * imgScaleX 
    p.y = (p.y + imgOffsetY) * imgScaleY
  }
  
  Void widgetToImg(Coord p) {
    p.x = (p.x / imgScaleX) - imgOffsetX
    p.y = (p.y / imgScaleY) - imgOffsetY
  }

  new make(|This|? f := null)
  {
    //layout.width = Layout.wrapContent
    if (f != null) f(this)

    if (image == null && uri != null) {
      s := Unsafe<ImageView>(this)
      image = Image.fromUri(uri) {
        s.val.relayout
      }
    }
    
    if (enabled) {
      focusable = true
      pressFocus = true
    }
  }

  protected override Size prefContentSize() {
    w := dpToPixel(imagePrefWidth)
    h := dpToPixel(imagePrefHeight)
    return Size(w, h)
  }
  
  protected override Void motionEvent(MotionEvent e)
  {
    super.motionEvent(e)
    if (e.consumed) return
    if (e.type == MotionEvent.wheel && e.delta != null) {
        scale := e.delta > 0 ? 0.8 : 1.25
        zoom(e.relativeX.toFloat, e.relativeY.toFloat, scale)
    }
  }
  
  protected Void zoom(Float vx, Float vy, Float scale) {
    //echo("zoom:$vx, $vy, $scale")
    pos := Coord(vx, vy)
    widgetToImg(pos)
    imgX := pos.x
    imgY := pos.y
    
    imgScaleX *= scale
    imgScaleY *= scale
    
    xx := vx / imgScaleX
    yy := vy / imgScaleY
    imgOffsetX = xx - imgX
    imgOffsetY = yy - imgY
    //echo("imgX:$imgX, xx:$xx, imgY:$imgY, yy:$yy")
    this.repaint
  }
  
  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    if (e.consumed) return
    if (e.type == GestureEvent.drag) {
      imgOffsetX += e.deltaX/imgScaleX
      imgOffsetY += e.deltaY/imgScaleX
      this.repaint
      //echo("imgScaleX:$imgScaleX, imgScaleY")
      e.consume
    }
    if (e.type == GestureEvent.multiTouch) {
        MultiTouchEvent me := e
        //echo("multiTouch:$e")
        zoom(me.centerX, me.centerY, me.scale)
        e.consume
    }
  }
}
