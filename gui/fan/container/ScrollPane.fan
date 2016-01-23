//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
abstract class ScrollBase : Pane
{
  @Transient
  protected ScrollBar hbar

  @Transient
  protected ScrollBar vbar

  @Transient
  virtual Int offsetX := 0

  @Transient
  virtual Int offsetY := 0

  Float barSize := 60f

  Bool autoAdjustChildren := false

  @Transient
  private Animation? animation

  new make()
  {
    //scroll bar
    hbar = ScrollBar { vertical = false; it.barSize = this.barSize; it.layoutParam.ignore = true }
    vbar = ScrollBar { vertical = true; it.barSize = this.barSize; it.layoutParam.ignore = true }

    hbar.onPosChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#curPos)
      {
        newVal := ((Float)e.newValue)
        oldVal := ((Float)e.oldValue)

        offsetX = newVal.toInt

        if (autoAdjustChildren) {
          dx := (newVal - oldVal).toInt
          this.each {
            it.x = it.x + dx
          }
        }

        this.requestPaint
      }
    }
    vbar.onPosChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#curPos)
      {
        newVal := ((Float)e.newValue)
        oldVal := ((Float)e.oldValue)

        offsetY = newVal.toInt

        if (autoAdjustChildren) {
          dy := (newVal - oldVal).toInt
          this.each {
            it.y = it.y + dy
          }
        }

        this.requestPaint
      }
    }

    doAdd(hbar)
    doAdd(vbar)
    layoutParam.heightType = SizeType.matchParent
    layoutParam.widthType = SizeType.matchParent
    padding = Insets(0, barSize.toInt, barSize.toInt, 0)
  }

  protected Void doAdd(Widget? child) { super.add(child) }

  protected virtual Float viewportWidth() { contentWidth.toFloat }

  protected virtual Float viewportHeight() { contentHeight.toFloat }

  protected virtual Float contentMaxWidth(Dimension result) {
    bs := prefContentSize(result)
    return bs.w.toFloat
  }

  protected virtual Float contentMaxHeight(Dimension result) {
    bs := prefContentSize(result)
    return bs.h.toFloat
  }

  private Void layoutScroolBar(Dimension result) {
    barSize := dpToPixel(this.barSize)
    hbar.width = contentWidth + (barSize)
    hbar.height = (barSize)
    hbar.x = paddingLeft
    hbar.y = height-barSize
    hbar.max = contentMaxWidth(result)
    hbar.viewport = viewportWidth

    //echo("size$size, getContentHeight$getContentHeight, padding$padding")
    if (hbar.max <= hbar.viewport)
    {
      hbar.enabled = false
      hbar.visible = false
      offsetX = 0
    }
    else
    {
      hbar.enabled = true
      hbar.visible = true
    }

    vbar.width = barSize
    vbar.height = contentHeight
    vbar.x = width-barSize
    vbar.y = paddingTop
    vbar.max = contentMaxHeight(result)
    vbar.viewport = viewportHeight

    if (vbar.max <= vbar.viewport)
    {
      vbar.enabled = false
      vbar.visible = false
      offsetY = 0
    }
    else
    {
      vbar.enabled = true
      vbar.visible = true
    }

    //offset children
    if (autoAdjustChildren) {
      adjustContent
    }

  }

  override Void layoutChildren(Dimension result, Bool force)
  {
    hbar.detach
    vbar.detach

    layoutContent(result, force)

    layoutScroolBar(result)

    doAdd(hbar)
    doAdd(vbar)
  }

  protected virtual Void layoutContent(Dimension result, Bool force) {
    super.layoutChildren(result, force)
  }

  protected virtual Void adjustContent() {
    this.each {
      it.x = it.x - offsetX
      it.y = it.y - offsetY
    }
  }

  protected override Void motionEvent(MotionEvent e)
  {
    super.motionEvent(e)
    if (e.consumed) return

    if (vbar.max <= vbar.viewport) return

    if (e.type == MotionEvent.wheel && e.delta != null)
    {
      pos := vbar.curPos + e.delta * dpToPixel(80f)
      vbar.setCurPos(pos, true)
      vbar.requestPaint
      e.consume
    }
    else if (e.type == MotionEvent.pressed) {
      if (animation != null) {
        animation.stop
      }
    }
  }

  private Void startAnimation(Animation anim) {
    if (animation != null) {
      animation.stop
    }
    getRootView.animManager.add(anim)
    anim.start
    animation = anim
  }

  private Void animatOverScroll() {
    if (vbar.isOverScroll) {
      anim := Animation {
        duration = 2000
        OverScrollAnimChannel { target = vbar; startV = 0f },
      }
      startAnimation(anim)
    }
  }

  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    if (e.consumed) return

    if (e.type == GestureEvent.drag) {
      pos := vbar.curPos - (e.deltaY)
      vbar.setCurPos(pos, true, true)
      vbar.requestPaint
      e.consume
    }
    else if (e.type == GestureEvent.fling) {
      if (vbar.isOverScroll) {
        animatOverScroll
      } else {
        anim := Animation {
          duration = 2000
          ScrollAnimChannel { target = vbar; startV = e.speedY.toFloat },
        }
        startAnimation(anim)
      }
      vbar.requestPaint
    }
    else if (e.type == GestureEvent.drop) {
      animatOverScroll
    }
  }

}

@Js
class ScrollPane : ScrollBase {
  new make() {
    autoAdjustChildren = true
  }
}