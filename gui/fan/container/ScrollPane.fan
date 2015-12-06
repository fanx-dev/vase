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
abstract class ScrollBase : FrameLayout
{
  ScrollBar hbar
  ScrollBar vbar

  virtual Int offsetX := 0
  virtual Int offsetY := 0

  Int barSize := dpToPixel(30f)

  Bool autoAdjustChildren := false

  new make()
  {
    //scroll bar
    hbar = ScrollBar(false, barSize)
    vbar = ScrollBar(true, barSize)

    hbar.onStateChanged.add |StateChangedEvent e|
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
    vbar.onStateChanged.add |StateChangedEvent e|
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

    this.add(hbar)
    this.add(vbar)
    layoutParam.height = LayoutParam.matchParent
    layoutParam.width = LayoutParam.matchParent
    padding = Insets(0, barSize, barSize, 0)
  }

  protected virtual Int viewportWidth() { contentWidth }

  protected virtual Int viewportHeight() { contentHeight }

  private Dimension wrapContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    s := prefContentSize(result)
    return s
  }

  protected virtual Int contentMaxWidth(Dimension result) {
    bs := this.wrapContentSize(this.contentWidth, this.contentHeight, result)
    return bs.w
  }

  protected virtual Int contentMaxHeight(Dimension result) {
    bs := this.wrapContentSize(this.contentWidth, this.contentHeight, result)
    return bs.h
  }

  override Void layoutChildren(Dimension result, Bool force)
  {
    this.remove(hbar)
    this.remove(vbar)
    super.layoutChildren(result, force)

    hbar.width = contentWidth + barSize
    hbar.height = barSize
    hbar.x = padding.left
    hbar.y = height-barSize
    hbar.max = contentMaxWidth(result).toFloat
    hbar.viewport = viewportWidth.toFloat

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
    vbar.y = padding.top
    vbar.max = contentMaxHeight(result).toFloat
    vbar.viewport = viewportHeight.toFloat

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
      adjustChildren
    }
    this.add(hbar)
    this.add(vbar)

    //echo("x$hbar.x,y$hbar.y")
  }

  protected virtual Void adjustChildren() {
    each {
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
      vbar.curPos += e.delta * dpToPixel(40f)
      vbar.requestPaint
      e.consume
    }
  }

}

@Js
class ScrollPane : ScrollBase {
  new make() {
    autoAdjustChildren = true
  }
}