//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fgfxWtk

@Js
class Gesture
{
  MotionEvent[] history := [,]
  GestureState defaultState := NoneState(this)

  GestureState currentState := defaultState { private set }

  Int lastTouchTime := 0
  Int firstTouchTime := 0

  EventListeners onLingClick := EventListeners()
  EventListeners onClick := EventListeners()
  EventListeners onMultiTouch := EventListeners()
  EventListeners onFlingTouch := EventListeners()
  EventListeners onDoubleClick := EventListeners()
  EventListeners onMove := EventListeners()

  Void setCurrentState(GestureState newState, MotionEvent e) {
    currentState.onExit(e)
    newState.onEnter(e)
    currentState = newState
  }

  private Void reset() {
    currentState = defaultState
    lastTouchTime = 0
    firstTouchTime = 0
    history.clear
  }

  virtual Void onFinished(MotionEvent e) {
    reset
  }

  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  protected virtual Float dp() {
    Toolkit.cur.dpi.toFloat/320f
  }

  Int dpToPixel(Int d) { (d * dp).toInt }

  Int pixelToDp(Int p) { (p / dp).toInt }

  Void onEvent(MotionEvent e)
  {
    if (!history.isEmpty && history.last.pointers.size <= 1
      && e.type == MotionEvent.moved && e.pointers.size <= 1) {
      if (history.last.x == e.x && history.last.y == e.y) {
        return
      }
    }
    if (history.isEmpty) {
      firstTouchTime = Duration.nowTicks
    }

    if (e.pointers.size > 1) {
      ns := MultiTouchState(this)
      this.setCurrentState(ns, e)
    } else {
      defaultState.onEvent(e)
    }
    history.add(e)
    lastTouchTime = Duration.nowTicks
  }
}