//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** An implementation of a scrollbar.
**
@Js
class ScrollBar : Widget
{
  Int max := 500
  Int? viewPort := null

  Int startPos := 0
  {
    set
    {
      val := it
      if (it + thumbSize > max)
      {
        val = max - thumbSize
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

  Bool orientationV := true

  private Int x := -1
  private Int y := -1
  private Bool draging := false

  new make()
  {
    size = Size(10, 100)
  }

  private Int thumbSize()
  {
    if (viewPort != null) return viewPort

    if (orientationV)
    {
      return size.h
    }
    else
    {
      return size.w
    }
  }

  Int toViewCoord(Int val)
  {
    if (orientationV)
    {
      return (val.toFloat * size.h.toFloat / max.toFloat).toInt
    }
    else
    {
      return (val.toFloat * size.w.toFloat / max.toFloat).toInt
    }
  }

  Int toWorldCoord(Int val)
  {
    if (orientationV)
    {
      return (val.toFloat * max.toFloat / size.h.toFloat).toInt
    }
    else
    {
      return (val.toFloat * max.toFloat / size.w.toFloat).toInt
    }
  }

  override Void touch(MotionEvent e)
  {
    p := mapToRelative(Point(e.x, e.y))
    if (this.bounds.contains(p.x, p.y))
    {
      if (e.id == MotionEvent.pressed)
      {
        draging = true
        x = p.x
        y = p.y
        focus
        return
      }
    }

    if (!draging) return

    if (e.id == MotionEvent.released)
    {
      draging = false
      x = -1
      y = -1
    }
    else if (e.id == MotionEvent.moved)
    {
      if (orientationV)
      {
        startPos = toWorldCoord(p.y - y) + startPos
      }
      else
      {
        startPos = toWorldCoord(p.x - x) + startPos
      }
      x = p.x
      y = p.y
      repaint
    }
  }
}