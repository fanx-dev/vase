//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** An implementation of a scrollbar.
**
@Js
class ScrollBar : Widget
{
  **
  ** max content length
  **
  Int max := dpToPixel(2000)

  **
  ** size of bar
  **
  Int viewport := 0

  **
  ** start position at content
  **
  Int startPos := 0
  {
    set
    {
      val := it
      if (it + viewport > max)
      {
        val = max - viewport
      }
      else if (it < 0)
      {
        val = 0
      }
      else
      {
        val = it
      }

      if (&startPos == val) return
      &startPos = val
      e := StateChangedEvent (&startPos, val, #startPos, this )
      onStateChanged.fire(e)
    }
  }

  **
  ** is vertical
  **
  Bool vertical { private set }

  **
  ** touch position
  **
  private Int lastX := -1
  private Int lastY := -1
  private Bool draging := false

  new make(Bool vertical, Int width)
  {
    this.vertical = vertical
    if (vertical) {
      layoutParam.width = width
      layoutParam.height = LayoutParam.matchParent
    }
    else {
      layoutParam.height = width
      layoutParam.width = LayoutParam.matchParent
    }
  }

  Int barLength() {
    if (vertical) {
      return this.getContentHeight
    } else {
      return this.getContentWidth
    }
  }

  **
  ** screen thumb size
  **
  Int thumbSize()
  {
    return ((viewport.toFloat / max) * barLength.toFloat).toInt
  }

  Int screenPos() {
    toViewCoord(startPos)
  }

  **
  ** maping from world to screen
  **
  protected Int toViewCoord(Int val)
  {
    return ((val.toFloat / max.toFloat) * barLength.toFloat).toInt
  }

  **
  ** map from screen to world
  **
  protected Int toWorldCoord(Int val)
  {
    return ((val.toFloat /barLength.toFloat )* max).toInt
  }

  override Void onMounted()
  {
    rootVie := this.getRootView
    rootVie.onTouchDown.add |MotionEvent e|
    {
      doTouch(e)
    }
    rootVie.onTouchUp.add |MotionEvent e|
    {
      doTouch(e)
    }
    rootVie.onTouchMove.add |MotionEvent e|
    {
      doTouch(e)
    }
  }

  private Void doTouch(MotionEvent e)
  {
    p := Coord(e.x, e.y)
    rc := mapToRelative(p)
    if (rc && this.bounds.contains(p.x, p.y))
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
        startPos = toWorldCoord(p.y - lastY) + startPos
      }
      else
      {
        startPos = toWorldCoord(p.x - lastX) + startPos
      }
      lastX = p.x
      lastY = p.y
      requestPaint
    }
  }
}