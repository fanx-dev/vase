//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseWindow

@Js
virtual class GestureEvent : Event {
  const static Int click := 1
  const static Int longPress := 2
  const static Int fling := 3
  const static Int doubleClick := 4
  const static Int drag := 5
  const static Int drop := 6
  const static Int multiTouch := 7

  **
  ** X coordinates
  **
  Int? x

  **
  ** Y coordinates
  **
  Int? y

  **
  ** delta x
  **
  Int? deltaX

  **
  ** delta y
  **
  Int? deltaY

  **
  ** Current pressure of pointer
  **
  Float? pressure

  **
  ** Current size of pointer
  **
  Float? size

  **
  ** pixel move per millisecond
  **
  Float? speedX

  Float? speedY

  Int? relativeX
  Int? relativeY


  new make(Int type)
  {
    this.type = type
  }
}

@Js
class Gesture
{
  MotionEvent[] history := [,]
  GestureState defaultState := NoneState(this)

  GestureState currentState := defaultState { private set }

  Int lastTouchTime := 0
  Int firstTouchTime := 0

  Int longPressTimeLimit := 600
  Int doubleClickTimeLimt := 150
  Bool supportDoubleClick := false

  EventListeners onGestureEvent := EventListeners()

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

  private Bool isMultiTouch(MotionEvent e) {
    e.pointers != null && e.pointers.size > 1
  }

  Void onEvent(MotionEvent e)
  {
    if (!history.isEmpty && !isMultiTouch(history.last)
      && e.type == MotionEvent.moved && !isMultiTouch(e)) {
      if (history.last.x == e.x && history.last.y == e.y) {
        return
      }
    }
    if (history.isEmpty) {
      firstTouchTime = Duration.nowTicks
    }

    if (e.pointers != null && e.pointers.size > 1) {
      ns := MultiTouchState(this)
      this.setCurrentState(ns, e)
    } else {
      currentState.onEvent(e)
    }
    //echo("raw e.type=>$e.type")
    history.add(e)
    lastTouchTime = Duration.nowTicks
  }
}