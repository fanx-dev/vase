// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-4-27 yangjiandong Creation
//

using vaseWindow


@Js
class PushCard : Pane
{

  Float maxOffset := 1.0
  Float minOffset := 0.0

  @Transient
  Float offsetY := 0f {
    set {
      oldVal := &offsetY
      &offsetY = it

      fireStateChange(oldVal, it, #offsetY)

      if (&offsetY != oldVal) {
        this.relayout
      }
    }
  }
  
  new make() {
    gestureFocusable = true
  }

  private Void pushDrop() {
    to := maxOffset
    if (offsetY < (minOffset+maxOffset)/2f ) {
        to = minOffset
    }

    anim := Animation {
      it.duration = 300
      FloatPropertyAnimChannel(this, #offsetY) {
        from = offsetY; it.to = to
      },
    }
    
    this.getRootView.animManager.add(anim)
    anim.start
    this.relayout
  }

  private Void pushOffset(Int delta) {
    endOffset := &offsetY + (delta/this.contentHeight.toFloat)
    if (endOffset >= minOffset && endOffset <= maxOffset) {
        &offsetY = endOffset
        this.relayout
    }
  }

  @Transient
  private Int lastY := -1
  private Int pushUp := -1

  protected override Void motionEvent(MotionEvent e) {

    if (e.type == MotionEvent.pressed) {
        lastY = e.y
    }
    else if (e.type == MotionEvent.moved) {
        if (lastY != -1 && pushUp == -1) {
            delta := e.y - lastY
            if (delta < 0) {
                if (offsetY > minOffset && offsetY <= maxOffset) {
                    pushUp = 1
                }
            }
            else if (delta > 0) {
                pushUp = 0
            }
        }
    }
    else if (e.type == MotionEvent.released) {
        if (lastY != -1) {
            lastY = -1
            pushUp = -1
        }
    }

    super.motionEvent(e)

    if (pushUp > 0) {
        this.getRootView?.gestureFocus(this)
    }
  }

  protected override Void gestureEvent(GestureEvent e) {
    //echo("gestureEvent:$e")
    if (e.type == GestureEvent.drag) {
        pushOffset(e.deltaY)
    }
    else if (e.type == GestureEvent.drop) {
        pushDrop
    }

    if (pushUp > 0) {
        e.consume
    }
    else {
        super.gestureEvent(e)
    }
  }
  
  override Void layoutChildren(Bool force)
  {
    super.layoutChildren(force)
    this.each |Widget c, i|
    {
        c.y += (offsetY * this.contentHeight).toInt
    }
  }
}
