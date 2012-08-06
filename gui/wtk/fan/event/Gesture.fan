//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

@Js
class Gesture
{
  static const Duration clickDuration := 500ms
  MotionEvent? down
  MotionEvent? move
  MotionEvent? up
  MotionEvent? preDown
  MotionEvent? preMove
  MotionEvent? preUp

  Void add(MotionEvent e)
  {
    if (e.id == MotionEvent.pressed)
    {
      preDown = down
      preUp = up
      preMove = move
      down = e
      move = null
      up = null
    }
    else if (e.id == MotionEvent.moved)
    {
      move = e
    }
    else if (e.id == MotionEvent.released)
    {
      up = e
    }
  }

  Bool isClick()
  {
    if (up != null && down != null && move == null && (up.time - down.time) < clickDuration)
    {
      return true
    }
    return false
  }

  Bool isLongPress()
  {
    if (down != null && move == null && (DateTime.now - down.time) > clickDuration)
    {
      return true
    }
    return false
  }
}