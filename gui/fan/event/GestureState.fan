//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseWindow

@Js
abstract class GestureState
{
  Gesture machine { private set }

  new make(Gesture machine) {
    this.machine = machine
  }

  GestureEvent makeEvent(MotionEvent e, Int type) {
    ge := GestureEvent(type)
    ge.x = e.x
    ge.y = e.y
    ge.pressure = e.pressure
    ge.size = e.size
    ge.speedX = e.speed
    ge.speedY = e.speed
    ge.rawEvent = e
    return ge
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
  Int lastX := 0
  Int lastY := 0

  new make(Gesture machine) : super(machine) {
  }

  override Void onEnter(MotionEvent e) {
    valid = true
    Toolkit.cur.callLater(machine.longPressTimeLimit) |->|{
      if (machine.currentState == this && valid) {

        ge := makeEvent(e, GestureEvent.longPress)
        machine.onGestureEvent.fire(ge)
        e.consume
        machine.onFinished(e)
      }
      lastX = e.x
      lastY = e.y
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    //ignore raw event
    if (e.type == MotionEvent.longPressed || e.type == MotionEvent.clicked) return

    if (e.type == MotionEvent.released) {
      if (machine.supportDoubleClick) {
        ns := OneClickState(machine)
        machine.setCurrentState(ns, e)
      } else {
        //send click event
        ge := makeEvent(e, GestureEvent.click)
        machine.onGestureEvent.fire(ge)
        e.consume
        machine.onFinished(e)
      }
    } else if (e.type == MotionEvent.moved) {
      dx := e.x - lastX
      dy := e.y - lastY
      distance := (dx*dx + dy*dy).toFloat.sqrt

      if (distance > DisplayMetrics.dpToPixel(80f).toFloat) {
        ns := DragState(machine)
        machine.setCurrentState(ns, e)
      } else {
        lastX = e.x
        lastY = e.y
      }
    } else {
      machine.onFinished(e)
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
    Toolkit.cur.callLater(machine.doubleClickTimeLimt) |->|{
      if (machine.currentState == this && valid) {
        ge := makeEvent(e, GestureEvent.click)
        machine.onGestureEvent.fire(ge)
        e.consume
        machine.onFinished(e)
      }
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    //ignore raw event
    if (e.type == MotionEvent.other || e.type == MotionEvent.clicked) return

    if (e.type == MotionEvent.pressed) {
      ns := TwoDownState(machine)
      machine.setCurrentState(ns, e)
    } else {
      machine.onFinished(e)
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
    Toolkit.cur.callLater(machine.longPressTimeLimit) |->|{
      if (machine.currentState == this && valid) {
        ge := makeEvent(e, GestureEvent.longPress)
        ge.flag = 1
        machine.onGestureEvent.fire(ge)
        e.consume
        machine.onFinished(e)
      }
      valid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.longPressed) return
    if (e.type == MotionEvent.released) {
      ge := makeEvent(e, GestureEvent.doubleClick)
      machine.onGestureEvent.fire(ge)
      e.consume
      machine.onFinished(e)
    } else if (e.type == MotionEvent.moved) {
      ns := DragState(machine)
      ns.click = true
      machine.setCurrentState(ns, e)
    } else {
      machine.onFinished(e)
    }
    valid = false
  }
}

@Js
class DragState : GestureState {
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
    Int elapsedTime := (Duration.nowTicks - beginTime) / 1000_000
    //if (elapsedTime > 1000) return false
    dx := e.x - beginX
    dy := e.y - beginY
    distance := (dx*dx + dy*dy).toFloat.sqrt
    minDis := DisplayMetrics.dpToPixel(100f).toFloat
    if (distance > minDis) {
      ge := makeEvent(e, GestureEvent.fling)
      ge.deltaX = dx
      ge.deltaY = dy
      if (click) {
        ge.flag = 1
      }
      ge.speedX = dx.toFloat / elapsedTime
      ge.speedY = dy.toFloat / elapsedTime
      machine.onGestureEvent.fire(ge)
      e.consume
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

      ge := makeEvent(e, GestureEvent.drag)
      ge.deltaX = dx
      ge.deltaY = dy
      if (click) {
        ge.flag = 1
      }
      machine.onGestureEvent.fire(ge)
      e.consume

    } else if (e.type == MotionEvent.released
        || e.type == MotionEvent.cancel) {
      if (asFling(e)) {
        return
      }
      ge := makeEvent(e, GestureEvent.drop)
      machine.onGestureEvent.fire(ge)
      e.consume
      machine.onFinished(e)
    } else {
      machine.onFinished(e)
    }
  }
}