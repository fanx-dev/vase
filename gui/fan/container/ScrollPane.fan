//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class ScrollPane : ContentPane
{
  @Transient
  protected ScrollBar hbar

  @Transient
  protected ScrollBar vbar

  @Transient
  virtual Int offsetX := 0

  @Transient
  virtual Int offsetY := 0

  protected Float barSize := 50f

  Bool autoScrollContent := true

  @Transient
  private Animation? animation
  
  |Widget|? onRefresh
  |Widget|? onLoadMore
  Widget? refreshTip

  new make()
  {
    clip = true
    //scroll bar
    hbar = ScrollBar { vertical = false; it.barSize = this.barSize; it.layout.ignore = true }
    vbar = ScrollBar { vertical = true; it.barSize = this.barSize; it.layout.ignore = true }

    hbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#curPos)
      {
        newVal := ((Float)e.newValue)
        oldVal := ((Float)e.oldValue)

        offsetX = newVal.toInt

        if (autoScrollContent) {
          dx := (newVal - oldVal)
          if (content != null) {
            content.x = (content.x - dx).round.toInt
          }
        }
        onViewportChanged
        this.repaint
      }
    }
    vbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#curPos)
      {
        newVal := ((Float)e.newValue)
        oldVal := ((Float)e.oldValue)

        offsetY = newVal.toInt

        if (autoScrollContent) {
          dy := (newVal - oldVal)
          if (content != null) {
            content.y = (content.y - dy).round.toInt
          }
        }
        onViewportChanged
        this.repaint
      }
    }

    doAdd(hbar)
    doAdd(vbar)
    layout.height = Layout.matchParent
    layout.width = Layout.matchParent
    //padding = Insets(0, barSize.toInt, barSize.toInt, 0)
    padding = Insets(0, 8, 8, 0)
    focusable = true
    pressFocus = true
  }

  protected virtual Void onViewportChanged() {}

  protected virtual Float viewportWidth() { contentWidth.toFloat }

  protected virtual Float viewportHeight() { contentHeight.toFloat }

  protected virtual Float contentMaxWidth() {
    bs := prefContentSize()
    return bs.w.toFloat
  }

  protected virtual Float contentMaxHeight() {
    bs := prefContentSize()
    return bs.h.toFloat
  }

  private Void layoutScroolBar() {
    barSize := dpToPixel(this.barSize)
    hbar.width = contentWidth + barSize
    hbar.height = barSize
    hbar.x = paddingLeft
    hbar.y = height-barSize
    hbar.max = contentMaxWidth()
    hbar.viewport = viewportWidth

    //echo("size$size, contentWidth$contentWidth, padding$padding")
    if (hbar.max <= hbar.viewport)
    {
      hbar.enabled = false
      hbar.visible = false
      offsetX = 0
      hbar.max = hbar.viewport
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
    vbar.max = contentMaxHeight()
    vbar.viewport = viewportHeight

    if (vbar.max <= vbar.viewport)
    {
      vbar.enabled = false
      vbar.visible = false
      //offsetY = 0
      vbar.max = vbar.viewport
    }
    else
    {
      vbar.enabled = true
      vbar.visible = true
    }

  }

  override Void layoutChildren(Bool force)
  {
    //hbar.detach
    //vbar.detach

    super.layoutChildren(force)
    layoutScroolBar()
    //offset children
    if (autoScrollContent) {
      adjustContent
    }
    //doAdd(hbar)
    //doAdd(vbar)
    onViewportChanged
  }

  protected virtual Void adjustContent() {
    if (content != null) {
      content.x -= offsetX
      content.y -= offsetY
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
      vbar.repaint
      e.consume
    }
    else if (e.type == MotionEvent.pressed) {
      if (animation != null) {
        animation.stop
      }
      this.focus
    }
    else if (e.type == MotionEvent.moved) {
        if (refreshTip != null) {
          if (vbar.curPos < -dpToPixel(100f).toFloat) {
            if (refreshTip.parent == null) {
              this.doAdd(refreshTip)
              this.relayout
            }
          }
          else if (refreshTip.parent != null) {
            this.remove(refreshTip)
            this.relayout
          }
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
    this.repaint
  }

  private Void animatOverScroll() {
    if (vbar.isOverScroll) {
      anim := Animation {
        duration = 1500
        OverScrollAnimChannel {
            acceleration = vbar.overScrollVal/10000.0
            target = vbar
        },
      }
      startAnimation(anim)
    }
  }

  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    if (e.consumed) return
    
    //if (!vbar.enabled) return
    if (e.type == GestureEvent.drag) {
      if (e.deltaY.abs > e.deltaX.abs) {
        if (vbar.enabled) {
          pos := vbar.curPos - (e.deltaY)
          vbar.setCurPos(pos, true, true)
          vbar.repaint
        }
      }
      else {
        if (hbar.enabled) {
          pos := hbar.curPos - (e.deltaX)
          hbar.setCurPos(pos, true)
          hbar.repaint
        }
      }
      e.consume
    }
    else if (e.type == GestureEvent.drop) {
      //echo("drop: $vbar.isOverScroll")
      if (vbar.isOverScroll) {
        animatOverScroll
        if (vbar.curPos < 0f) {
           if (vbar.curPos < -dpToPixel(100f).toFloat) {
             onRefresh?.call(this)
             //echo("onRefresh")
           }
        }
        else {
           onLoadMore?.call(this)
           //echo("onLoadMore")
        }
      }
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
      vbar.repaint
    }
  }

}
