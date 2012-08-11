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
class ScrollPane : ContentPane
{
  ScrollBar hbar
  ScrollBar vbar

  new make()
  {
    hbar = ScrollBar()
    hbar.orientationV = false
    vbar = ScrollBar()
    vbar.orientationV = true

    hbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        content.pos = Point(-((Int)e.newValue), content.pos.y)
        this.repaint
      }
    }
    vbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        content.pos = Point(content.pos.x, -((Int)e.newValue))
        this.repaint
      }
    }

    this.doAdd(hbar)
    this.doAdd(vbar)

    size = Size(200, 200)
  }

  override This relayout()
  {
    content.size = Size(400, 400)
    content.relayout
    hbar.size = Size(size.w-10, 10)
    hbar.pos = Point(0, size.h-10)
    hbar.max = content.size.w

    vbar.size = Size(10, size.h-10)
    vbar.pos = Point(size.w-10, 0)
    vbar.max = content.size.h

    this.remove(hbar)
    this.remove(vbar)
    this.doAdd(hbar)
    this.doAdd(vbar)
    return this
  }

  override Size prefSize(Size? hints := null) { return size }

  override Void touch(MotionEvent e)
  {
    super.touch(e)
    if (!e.consumed)
    {
      p := mapToRelative(Point(e.x, e.y))
      if (!this.bounds.contains(p.x, p.y)) return

      if (e.id == MotionEvent.other && e.delta != null)
      {
        vbar.startPos += e.delta * 10
      }
    }
  }
}