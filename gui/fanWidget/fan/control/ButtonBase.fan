//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanWt
using fan2d

class ButtonBase : WidgetGroup
{
//////////////////////////////////////////////////////////////////////////
// state
//////////////////////////////////////////////////////////////////////////
  const static Int mouseOver := 0
  const static Int mouseOut := 1
  const static Int mouseDown := 2

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

  override Void touch(InputEvent e)
  {
    if (this.bounds.contains(e.x, e.y))
    {
      if (e.type == InputEventType.release)
      {
        state = mouseOver
        onAction.fire(e)
      }
      else if (e.type == InputEventType.press)
      {
        state = mouseDown
      }
      else if (e.type == InputEventType.move)
      {
        if (state != mouseDown)
          state = mouseOver
      }
    }
    else
    {
      state = mouseOut
    }
  }

  override Void keyPress(InputEvent e)
  {
    if (e.type == InputEventType.release && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }
}