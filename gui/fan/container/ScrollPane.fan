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
  ScrollBar hbar

  @Transient
  ScrollBar vbar

  @Transient
  virtual Int offsetX := 0

  @Transient
  virtual Int offsetY := 0

  Float barSize := 60f

  Bool autoAdjustChildren := false

  new make()
  {
    //scroll bar
    hbar = ScrollBar { vertical = false; it.barSize = this.barSize }
    vbar = ScrollBar { vertical = true; it.barSize = this.barSize }

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
    layoutParam.heightType = SizeType.matchParent
    layoutParam.widthType = SizeType.matchParent
    padding = Insets(0, barSize.toInt, barSize.toInt, 0)
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

    barSize := dpToPixel(this.barSize)
    hbar.width = contentWidth + (barSize)
    hbar.height = (barSize)
    hbar.x = paddingLeft
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
    vbar.y = paddingTop
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
      vbar.curPos += e.delta * dpToPixel(80f)
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