//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseWindow

@Js
class MultiTouchEvent : GestureEvent {
  Float centerX
  Float centerY
  Float distance
  Float scale
  Float rotate
  Float offsetX
  Float offsetY
  
  new make() : super.make(GestureEvent.multiTouch) {
  }
}

@Js
class MultiTouchState : GestureState {
  Int x0 := 0
  Int y0 := 0
  Int x1 := 0
  Int y1 := 0

  Float centerX := 0f
  Float centerY := 0f
  Float distance := 0f

  new make(Gesture machine) : super(machine) {}

  override Void onEnter(MotionEvent e) {
    e1 := e.pointers[0]
    e2 := e.pointers[1]
    x0 = e1.x
    y0 = e1.y
    x1 = e2.x
    y1 = e2.y

    distance = getDistance(x0, y0, x1, y1)
    centerX = (x0+x1)/2f
    centerY = (y0+y1)/2f
  }

  **
  ** get distance of two Point
  **
  static Float getDistance(Int x1, Int y1, Int x2, Int y2) {
    dx := x2 - x1
    dy := y2 - y1
    return (dx*dx + dy*dy).toFloat.sqrt
  }

  **
  ** get dotProduct of two vector
  **
  static Float dotProduct(Int x1, Int y1, Int x2, Int y2) {
    return (x1*x2+y1*y2).toFloat
  }

  **
  ** get angle of two vector
  **
  static Float getAngle(Int x1, Int y1, Int x2, Int y2) {
    product := dotProduct(x1, y1, x2, y2)
    len1 := (x1*x1 + y1*y1).toFloat.sqrt
    len2 := (x2*x2 + y2*y2).toFloat.sqrt

    return product / (len1 * len2)
  }

  override Void onEvent(MotionEvent e) {
    if (e.pointers == null || (e.pointers != null && e.pointers.size <= 1)) {
      //echo("endMultiTouch:$e")
      machine.onFinished(e)
      return
    }

    //echo(e)

    if (e.type == MotionEvent.moved) {
      e1 := e.pointers[0]
      e2 := e.pointers[1]
      nx0 := e1.x
      ny0 := e1.y
      nx1 := e2.x
      ny1 := e2.y

      ndistance := getDistance(nx0, ny0, nx1, ny1)
      ncenterX := (nx0+nx1)/2f
      ncenterY := (ny0+ny1)/2f


      MultiTouchEvent multiEvent := MultiTouchEvent() {
        it.distance = ndistance
        it.centerX = ncenterX
        it.centerY = ncenterY
        it.x = nx0
        it.y = ny0
        it.relativeX = it.x
        it.relativeY = it.y
      }

      multiEvent.scale = ndistance / distance
      multiEvent.offsetX = ncenterX - centerX
      multiEvent.offsetY = ncenterY - centerY

      //compute sclae
      dx := x1 - x0
      dy := y1 - y0
      ndx := nx1 - nx0
      ndy := ny1 - ny0
      angle := getAngle(dx, dy, ndx, ndy)
      multiEvent.rotate = angle

      x0 = nx0
      y0 = ny0
      x1 = nx1
      y1 = ny1
      distance = ndistance
      centerX = ncenterX
      centerY = ncenterY

      multiEvent.rawEvent = e
      machine.onGestureEvent.fire(multiEvent)
      if (multiEvent.consumed) e.consume
    }
  }
}