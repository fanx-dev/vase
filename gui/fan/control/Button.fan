//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** common behaviors for buttons.
**
@Js
class Button : Label
{
//////////////////////////////////////////////////////////////////////////
// state
//////////////////////////////////////////////////////////////////////////
  const static Int mouseOver := 0
  const static Int mouseOut := 1
  const static Int mouseDown := 2

  @Transient
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
  
  new make() {
    padding = Insets(25)
    textAlign = Align.center
  }

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

  protected once EventListeners onAction() { EventListeners() }

  protected override Void gestureEvent(GestureEvent e) {
    //super.gestureEvent(e)
    //if (e.consumed) return

    if (e.type == GestureEvent.click) {
      this.focus
      clicked
      onAction.fire(e)
      e.consume
    }
//    echo("e.type $e.type")
  }

  protected override Void motionEvent(MotionEvent e)
  {
    //echo("e.type $e.type, $id")
    super.motionEvent(e)

    if (state == mouseOut) {
      getRootView?.mouseCapture(this)
    }

    if (e.type == MotionEvent.released)
    {
      state = mouseOver
    }
    else if (e.type == MotionEvent.pressed)
    {
      state = mouseDown
    }
  }

  override protected Void clicked() {
    try {
      onClickCallback?.call(this)
    } catch (Err e) {
      e.trace
    }
  }

  override Void mouseExit() { state = mouseOut }

  override Void mouseEnter() { state = mouseOver }

  override Void keyEvent(KeyEvent e)
  {
    if (e.type == KeyEvent.released && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }
}
