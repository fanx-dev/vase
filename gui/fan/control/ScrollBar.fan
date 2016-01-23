//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** An implementation of a scrollbar.
**
@Js
class ScrollBar : Widget
{
  **
  ** max content length
  **
  Float max := (2000f)

  **
  ** view size of content
  **
  Float viewport := 0f

  **
  ** start position at content
  **
  Float curPos := 0f { private set }

  Bool isOverScroll() {
    if (curPos + viewport > max) {
      return true
    }
    else if (curPos < 0f) {
      return true
    }
    return false
  }

  Void setCurPos(Float pos, Bool fireEvent, Bool allowOverScroll := false) {
    val := pos

    if (!allowOverScroll) {
      if (pos + viewport > max) {
        val = max - viewport
      }
      else if (pos < 0f) {
        val = 0f
      }
    }

    if (curPos == val) return
    curPos = val
    //echo("curPos:$curPos")

    e := StateChangedEvent (&curPos, val, #curPos, this )
    onStateChanged.fire(e)

    if (fireEvent) {
      onPosChanged.fire(e)
    }
  }

  once EventListeners onPosChanged() { EventListeners() }

  **
  ** is vertical
  **
  Bool vertical := true { internal set }

  **
  ** touch position
  **
  private Int lastX := -1
  private Int lastY := -1
  private Bool draging := false

  Float barSize := 60f

  new make(|This|? f := null)
  {
    if (f != null) f(this)

    if (vertical) {
      layoutParam.widthType = SizeType.fixed
      layoutParam.widthVal = barSize
      layoutParam.heightType = SizeType.matchParent
    }
    else {
      layoutParam.heightType = SizeType.fixed
      layoutParam.heightVal = barSize
      layoutParam.widthType = SizeType.matchParent
    }
  }

  **
  ** bar length in screen coordinate
  **
  Int barLength() {
    if (vertical) {
      return this.contentHeight
    } else {
      return this.contentWidth
    }
  }

  **
  ** screen thumb size
  **
  Int thumbSize()
  {
    return toScreenCoord(viewport).toInt
  }

  Int screenPos() {
    toScreenCoord(curPos).toInt
  }

  **
  ** maping from world to screen
  **
  protected Float toScreenCoord(Float val)
  {
    return ((val.toFloat / max.toFloat) * barLength.toFloat)
  }

  **
  ** map from screen to world
  **
  protected Float toWorldCoord(Float val)
  {
    return ((val.toFloat /barLength.toFloat )* max)
  }

  override Void onMounted()
  {
    rootVie := this.getRootView
    rootVie.onTouchEvent.add |MotionEvent e|
    {
      doTouch(e)
    }
  }

  private Void doTouch(MotionEvent e)
  {
    p := Coord(e.x, e.y)
    rc := mapToRelative(p)
    if (rc && this.contains(p.x, p.y))
    {
      if (e.type == MotionEvent.pressed)
      {
        draging = true
        lastX = p.x
        lastY = p.y
        focus
        e.consume
        return
      }
    }

    if (!draging) return
    e.consume

    if (e.type == MotionEvent.released)
    {
      draging = false
      lastX = -1
      lastY = -1
    }
    else if (e.type == MotionEvent.moved)
    {
      if (vertical)
      {
        pos := toWorldCoord((p.y - lastY).toFloat) + curPos
        setCurPos(pos, true)
      }
      else
      {
        pos := toWorldCoord((p.x - lastX).toFloat) + curPos
        setCurPos(pos, true)
      }
      //echo("=====>$curPos")
      lastX = p.x
      lastY = p.y
      requestPaint
    }
  }
}


**
** An implementation base scroll bar.
**
@Js
class SliderBar : ScrollBar
{
  new make() : super.make(|i|{ i.vertical = false; i.barSize = 120f })
  {
    this.viewport = 0f
    this.max = 100f
    this.padding = Insets(100)
  }
}