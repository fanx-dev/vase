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
      
      //ge := makeEvent(e, GestureEvent.pressed)
      //machine.onGestureEvent.fire(ge)
    }
  }

}

@Js
class DownState : GestureState {
  private Bool longPressValid := true
  private Bool shortPressValid := true
  Int lastX := 0
  Int lastY := 0

  new make(Gesture machine) : super(machine) {
  }

  override Void onEnter(MotionEvent e) {
    longPressValid = true
    shortPressValid = true
    lastX = e.x
    lastY = e.y

    Toolkit.cur.callLater(machine.longPressTimeLimit) |->|{
      //echo("check longPress ${longPressValid} ${machine.currentState === this}")
      if (machine.currentState === this && longPressValid) {
        ge := makeEvent(e, GestureEvent.longPress)
        machine.onGestureEvent.fire(ge)
        e.consume
        machine.onFinished(e)
      }
      longPressValid = false
    }
    
    Toolkit.cur.callLater(machine.shortPressTimeLimit) |->|{
      if (shortPressValid) {
        ge := makeEvent(e, GestureEvent.shortPress)
        machine.onGestureEvent.fire(ge)
      }
      shortPressValid = false
    }
  }

  override Void onEvent(MotionEvent e) {
    //ignore raw event
    if (e.type == MotionEvent.longPressed || e.type == MotionEvent.clicked) return

    if (e.type == MotionEvent.released) {
        if (shortPressValid) {
            ge := makeEvent(e, GestureEvent.shortPress)
            machine.onGestureEvent.fire(ge)
            shortPressValid = false
        }
//      if (machine.supportDoubleClick) {
        ns := OneClickState(machine)
        machine.setCurrentState(ns, e)
//      } else {
//        //send click event
//        ge := makeEvent(e, GestureEvent.click)
//        machine.onGestureEvent.fire(ge)
//        e.consume
//        machine.onFinished(e)
//      }
        longPressValid = false
    } else if (e.type == MotionEvent.moved) {
      dx := e.x - lastX
      dy := e.y - lastY
      distance := (dx*dx + dy*dy).toFloat.sqrt
      //echo(distance)
      if (distance > DisplayMetrics.dpToPixel(30f).toFloat) {
        ns := DragState(machine)
        machine.setCurrentState(ns, e)
        e.consume
        shortPressValid = false
        longPressValid = false
      }
    } else {
      machine.onFinished(e)
    }
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
      if (machine.currentState === this && valid) {
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
  Int beginTime := 0
  
  Int lastX := 0
  Int lastY := 0
  Int lastTime := 0
  Float lastSpeed := 0.0
  Float lastSpeedX := 0.0
  Float lastSpeedY := 0.0

  new make(Gesture machine) : super(machine) {}

  override Void onEnter(MotionEvent e) {
    beginX = e.x
    beginY = e.y
    lastX = e.x
    lastY = e.y
    beginTime = TimePoint.nowMillis
  }

  private Void fireDrop(MotionEvent e) {
    dx := e.x - beginX
    dy := e.y - beginY
    //echo(lastSpeed)
    ge := makeEvent(e, GestureEvent.drop)
    ge.deltaX = dx
    ge.deltaY = dy
    if (click) {
      ge.flag = 1
    }
    ge.speedX = lastSpeedX
    ge.speedY = lastSpeedY
    machine.onGestureEvent.fire(ge)
    e.consume
    machine.onFinished(e)
  }

  override Void onEvent(MotionEvent e) {
    if (e.type == MotionEvent.moved) {
      dx := e.x - lastX
      dy := e.y - lastY
      lastX = e.x
      lastY = e.y
      
      //update speed
      now := TimePoint.nowMillis
      Int elapsedTime := now - lastTime
      if (elapsedTime <= 0) elapsedTime = 1
      lastSpeed = (dx*dx + dy*dy).toFloat.sqrt/elapsedTime
      lastSpeedX = dx.toFloat/elapsedTime
      lastSpeedY = dy.toFloat/elapsedTime
      lastTime = now

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
      fireDrop(e)
      //ge0 := makeEvent(e, GestureEvent.released)
      //machine.onGestureEvent.fire(ge0)
    } else {
      machine.onFinished(e)
    }
  }
}