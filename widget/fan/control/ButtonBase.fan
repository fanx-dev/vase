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
** common behaviors for buttons.
**
@Js
abstract class ButtonBase : Label
{
//////////////////////////////////////////////////////////////////////////
// state
//////////////////////////////////////////////////////////////////////////
  const static Int mouseOver := 0
  const static Int mouseOut := 1
  const static Int mouseDown := 2

  private Bool pressed := false

  Int state := mouseOut
  {
    set
    {
      if (&state == it) return
      e := StateChangedEvent (&state, it, #state, this )
      onStateChanged.fire(e)
      &state = it
      this.requestPaint
    }
  }

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

  once EventListeners onAction() { EventListeners() }

  override Void touch(MotionEvent e)
  {
    p := Coord(e.x, e.y)
    rc := mapToRelative(p)
    if (!rc) return
    if (this.bounds.contains(p.x, p.y))
    {
      if (e.type == MotionEvent.released)
      {
        if (pressed)
        {
          //focus
          this.focus
          willClicked
          onAction.fire(e)
          e.consume
        }
        pressed = false
        state = mouseOver
      }
      else if (e.type == MotionEvent.pressed)
      {
        state = mouseDown
        pressed = true
      }
      else if (e.type == MotionEvent.moved)
      {
        if (state != mouseDown)
        {
          getRootView.mouseCapture(this)
        }
      }
    }
  }

  protected virtual Void willClicked() {
  }

  override Void mouseExit() { state = mouseOut }

  override Void mouseEnter() { state = mouseOver }

  override Void keyPress(KeyEvent e)
  {
    if (e.type == KeyEvent.released && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }
}