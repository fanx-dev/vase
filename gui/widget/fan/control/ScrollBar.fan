//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class ScrollBar : Widget
{
  Int max := 500

  Int startPos := 0
  {
    set
    {
      if (it + thumbSize > max)
      {
        &startPos = max - thumbSize
      }
      else if (it < 0)
      {
        &startPos = 0
      }
      else
      {
        &startPos = it
      }
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

  override Void touch(InputEvent e)
  {
    super.touch(e)
    if (this.bounds.contains(e.x, e.y))
    {
      if (e.type == InputEventType.press)
      {
        draging = true
        x = e.x
        y = e.y
        focus
        return
      }
    }

    if (!draging) return

    if (e.type == InputEventType.release)
    {
      draging = false
      x = -1
      y = -1
    }
    else if (e.type == InputEventType.move)
    {
      if (orientationV)
      {
        startPos = toWorldCoord(e.y - y) + startPos
      }
      else
      {
        startPos = toWorldCoord(e.x - x) + startPos
      }
      x = e.x
      y = e.y
      repaint
    }
  }
}