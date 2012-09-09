//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
abstract class Scroller : WidgetGroup
{
  ScrollBar hbar
  ScrollBar vbar

  virtual Int offsetX := 0
  virtual Int offsetY := 0

  Int barSize := 10

  new make()
  {
    //scroll bar
    hbar = ScrollBar()
    hbar.orientationV = false
    vbar = ScrollBar()
    vbar.orientationV = true

    hbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        offsetX = ((Int)e.newValue)
        this.repaint
      }
    }
    vbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        offsetY = ((Int)e.newValue)
        this.repaint
      }
    }

    this.add(hbar)
    this.add(vbar)
    size = Size(200, 200)
  }

  protected abstract Int contentWidth()

  protected abstract Int contentHeight()

  protected virtual Int viewportWidth() { this.size.w - barSize }

  protected virtual Int viewportHeight() { this.size.h - barSize }

  override This relayout()
  {
    this.remove(hbar)
    this.remove(vbar)
    super.relayout

    hbar.size = Size(size.w-barSize, barSize)
    hbar.pos = Point(0, size.h-barSize)
    hbar.max = contentWidth
    hbar.viewport = viewportWidth
    if (hbar.max <= hbar.size.w)
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

    vbar.size = Size(barSize, size.h-barSize)
    vbar.pos = Point(size.w-barSize, 0)
    vbar.max = contentHeight
    vbar.viewport = viewportHeight
    if (vbar.max <= vbar.size.h)
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

    this.add(hbar)
    this.add(vbar)
    return this
  }

  override Void touch(MotionEvent e)
  {
    vbar.touch(e)
    hbar.touch(e)
    if (!e.consumed)
    {
      p := mapToRelative(Point(e.x, e.y))
      if (!this.bounds.contains(p.x, p.y)) return
      if (vbar.max <= vbar.size.h) return

      if (e.id == MotionEvent.other && e.delta != null)
      {
        vbar.startPos += e.delta * 10
      }
    }
  }
}