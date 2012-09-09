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
** common behaviors for buttons.
**
@Js
abstract class ButtonBase : Widget
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
      this.repaint
    }
  }

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

  once EventListeners onAction() { EventListeners() }

  override Void touch(MotionEvent e)
  {
    p := mapToRelative(Point(e.x, e.y))
    if (p == null) return
    if (this.bounds.contains(p.x, p.y))
    {
      if (e.id == MotionEvent.released)
      {
        if (pressed)
        {
          //focus
          onAction.fire(e)
          e.consume
        }
        pressed = false
        state = mouseOver
      }
      else if (e.id == MotionEvent.pressed)
      {
        state = mouseDown
        pressed = true
      }
      else if (e.id == MotionEvent.moved)
      {
        if (state != mouseDown)
        {
          rootView.mouseCapture(this)
        }
      }
    }
  }

  override Void mouseExit() { state = mouseOut }

  override Void mouseEnter() { state = mouseOver }

  override Void keyPress(KeyEvent e)
  {
    if (e.id == KeyEvent.released && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }
}