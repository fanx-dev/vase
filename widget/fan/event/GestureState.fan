//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fgfxWtk

@Js
abstract class GestureState
{
  Gesture machine { private set }

  new make(Gesture machine) {
    this.machine = machine
  }

  virtual Void onEnter(MotionEvent e) {}
  virtual Void onExit(MotionEvent e) {}

  abstract Void onEvent(MotionEvent e)
}

@Js
class NoneState : GestureState {

  new make(Gesture machine) : super(machine) {}

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.pressed) {
      ns := DownState(machine)
      machine.setCurrentState(ns, e)
    }
  }
}

@Js
class DownState : GestureState {
  private Bool valid := true

  new make(Gesture machine) : super(machine) {
  }

  override Void onEnter(MotionEvent e) {
    valid = true
    Toolkit.cur.callLater(500) |->|{
      if (machine.currentState == this && valid) {
        machine.onLingClick.fire(e)
        machine.onFinished(e)
      }
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.released) {
      ns := OneClickState(machine)
      machine.setCurrentState(ns, e)
    } else if (e.type == MotionEvent.moved) {
      ns := MoveState(machine)
      machine.setCurrentState(ns, e)
    }
    valid = false
  }
}

@Js
class OneClickState : GestureState {
  private Bool valid := true
  new make(Gesture machine) : super(machine) {}

  override Void onEnter(MotionEvent e) {
    valid = true
    Toolkit.cur.callLater(200) |->|{
      if (machine.currentState == this && valid) {
        machine.onClick.fire(e)
        machine.onFinished(e)
      }
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.pressed) {
      ns := TwoDownState(machine)
      machine.setCurrentState(ns, e)
    }
    valid = false
  }
}

@Js
class TwoDownState : GestureState {
  private Bool valid := true

  new make(Gesture machine) : super(machine) {
  }

  override Void onEnter(MotionEvent e) {
    valid = true
    Toolkit.cur.callLater(500) |->|{
      if (machine.currentState == this && valid) {
        machine.onLingClick.fire(e)
        machine.onFinished(e)
      }
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.released) {
      machine.onDoubleClick.fire(e)
      machine.onFinished(e)
    } else if (e.type == MotionEvent.moved) {
      ns := MoveState(machine)
      ns.click = true
      machine.setCurrentState(ns, e)
    }
    valid = false
  }
}

@Js
class MoveState : GestureState {
  Bool click := false
  Int beginX := 0
  Int beginY := 0
  Int lastX := 0
  Int lastY := 0
  Int beginTime := 0

  new make(Gesture machine) : super(machine) {}

  override Void onEnter(MotionEvent e) {
    beginX = e.x
    beginY = e.y
    lastX = e.x
    lastY = e.y
    beginTime = Duration.nowTicks
  }

  Bool asFling(MotionEvent e) {
    Int elapsedTime := Duration.nowTicks - beginTime
    if (elapsedTime > 1000) return false
    dx := e.x - beginX
    dy := e.y - beginY
    distance := (dx*dx + dy*dy).toFloat.sqrt
    minDis := machine.dpToPixel(50).toFloat
    if (distance > minDis) {
      e.deltaX = dx
      e.deltaY = dy
      if (click) {
        e.flag = 1
      }
      e.speed = elapsedTime / distance
      machine.onFlingTouch.fire(e)
      machine.onFinished(e)
      return true
    }
    return false
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.moved) {
      dx := e.x - lastX
      dy := e.y - lastY
      lastX = e.x
      lastY = e.y

      e.deltaX = dx
      e.deltaY = dy
      if (click) {
        e.flag = 1
      }
      machine.onMove.fire(e)

    } else if (e.type == MotionEvent.released) {
      if (asFling(e)) {
        return
      }
      machine.onFinished(e)
    }
  }
}