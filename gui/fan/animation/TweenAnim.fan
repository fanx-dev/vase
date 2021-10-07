//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

@Js
class TweenAnimation : Animation {
  Widget? widget

  protected override Void onFinished() {
    super.onFinished
    widget.alpha = null
    widget.transform = null
  }

  protected override Void onStart() {
    if (widget.transform == null) {
      widget.transform = Transform2D.makeIndentity()
    }
    widget.getRootView.animManager.add(this)
    widget.repaint
  }

  This bind(Widget widget) {
    this.widget = widget
    channelList.each |TweenAnimChannel c| { c.widget = widget }
    return this
  }
}

@Js
abstract class TweenAnimChannel : AnimChannel {
  Widget? widget
  Interpolation interpolation := Interpolation()

  override Void update(Int elapsedTime, Int frameTime, Float percent, Float blendWeight) {
    Float p := interpolation.evaluate(percent)
    onUpdate(p)
    widget.repaint
  }

  abstract Void onUpdate(Float percent)
}

@Js
class TranslateAnimChannel : TweenAnimChannel {
  Point from := Point(0, 100)
  Point to := Point.defVal

  private Float lastX := 0f
  private Float lastY := 0f

  override Void onUpdate(Float percent) {
    x := from.x + ((to.x - from.x) * percent)
    y := from.y + ((to.y - from.y) * percent)
    dx := x-lastX
    dy := y-lastY
    
    //echo("dx$dx,dy$dy,lx$lastX,ly$lastY, $widget?.transform")
    lastX = x
    lastY = y
    
    if (widget != null && widget.transform != null) {
      widget.transform = widget.transform.translate(dx, dy)
    }
  }
}

@Js
class RotateAnimChannel : TweenAnimChannel {
  Float from := 0f
  Float to := 360f

  private Float lastRotate := 1f

  override Void onUpdate(Float percent) {
    rotate := (from + (to - from) * percent)
    drotate := rotate - lastRotate
    x := widget.width /2.0f
    y := widget.height /2.0f
    lastRotate = rotate
    if (widget != null && widget.transform != null) {
      widget.transform = widget.transform.rotate(drotate , x, y)
    }
  }
}

@Js
class AlphaAnimChannel : TweenAnimChannel {
  Float from := 0f
  Float to := 1f
  override Void onUpdate(Float percent) {
    //echo("update alpha $percent, this$this")
    alpha := (from + (to - from) * percent)
    widget.alpha = alpha
  }
}

@Js
class ScaleAnimChannel : TweenAnimChannel {
  Float from := 4f
  Float to := 1f

  private Float lastScale := 1f

  override Void onUpdate(Float percent) {
    scale := (from + (to - from) * percent)
    if (scale == 0.0) scale = 0.000000001
    dscale := scale / lastScale
    x := widget.width /2.0f
    y := widget.height /2.0f
    lastScale = scale
    if (widget != null && widget.transform != null) {
      widget.transform = Transform2D.makeTranslate(x, y) *
                         Transform2D.makeScale(dscale, dscale) * 
                         Transform2D.makeTranslate(-x, -y) *
                         widget.transform
    }
    //echo("x$x,y$y, scale:$scale, dscale:$dscale")
    //widget.transform.matrix = Transform2D.makeScale(0f, 100f, scale, scale)
  }
}