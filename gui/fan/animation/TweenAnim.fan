//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using concurrent
using fanvasMath

@Js
class TweenAnimation : Animation {
  Widget? widget

  protected override Void onFinised() {
    super.onFinised
    widget.alpha = null
    widget.transform = null
  }

  protected override Void onStart() {
    if (widget.transform == null) {
      widget.transform = Transform2D()
    }
    widget.repaint
  }

  This bind(Widget widget) {
    this.widget = widget
    channelList.each |TweenAnimChannel c| { c.widget = widget }
    widget.getRootView.animManager.add(this)
    //this.start
    //widget.repaint
    return this
  }
}

@Js
abstract class TweenAnimChannel : AnimChannel {
  Widget? widget
  Interpolation interpolation := Interpolation()

  override Void update(Int frameTime, Float percent, Float blendWeight) {
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
    lastX = x
    lastY = y
    //echo("dx$dx,dy$dy,lx$lastX,ly$lastY")
    widget?.transform?.translate(dx, dy)
  }
}

@Js
class RotateAnimChannel : TweenAnimChannel {
  Float from := 0f
  Float to := 1f

  private Float lastRotate := 1f

  override Void onUpdate(Float percent) {
    rotate := (from + (to - from) * percent)
    drotate := rotate - lastRotate
    x := widget.width /2.0f
    y := widget.height /2.0f
    lastRotate = rotate
    widget?.transform?.rotate(x, y, drotate)
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
    dscale := scale / lastScale
    x := widget.width /2.0f
    y := widget.height /2.0f
    lastScale = scale
    widget?.transform?.scale(x, y, dscale, dscale)
    //echo("x$x,y$y")
    //widget.transform.matrix = Transform2D.makeScale(0f, 100f, scale, scale)
  }
}