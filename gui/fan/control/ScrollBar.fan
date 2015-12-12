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
  Float curPos := 0f
  {
    set
    {
      val := it
      if (it + viewport > max)
      {
        val = max - viewport
      }
      else if (it < 0f)
      {
        val = 0f
      }
      else
      {
        val = it
      }

      if (&curPos == val) return
      &curPos = val
      e := StateChangedEvent (&curPos, val, #curPos, this )
      onStateChanged.fire(e)
      onChanged.fire(e)
    }
  }

  once EventListeners onChanged() { EventListeners() }

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

  Int barSize := dpToPixel(30f)

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
        curPos = toWorldCoord((p.y - lastY).toFloat) + curPos
      }
      else
      {
        curPos = toWorldCoord((p.x - lastX).toFloat) + curPos
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
class SeekBar : ScrollBar
{
  new make() : super.make()
  {
    this.vertical = false
    this.barSize = dpToPixel(50f)
    this.viewport = 0f
    this.max = 100f
    this.padding = Insets(dpToPixel(50f))
  }
}