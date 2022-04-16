//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using vaseGraphics


**
** Mouse event or Touch event
**
@Js
class MotionEvent : Event
{
  **
  ** X coordinates
  **
  Int x := 0

  **
  ** Y coordinates
  **
  Int y := 0

  **
  ** delta x
  **
  Int? deltaX

  **
  ** delta y
  **
  Int? deltaY

  **
  ** Delta value of event.  For mouse wheel events this is the
  ** amount the mouse wheel has traveled.
  **
  Int? delta

  **
  ** Number of mouse clicks.
  **
  Int? count

  **
  ** Mouse button number pressed
  **
  Int? button

  **
  ** Key code and modifiers.
  **
  Key? key

  **
  ** Current pressure of pointer
  **
  Float? pressure

  **
  ** Current size of pointer
  **
  Float? size

  **
  ** For muilt touch event
  **
  MotionEvent[]? pointers

  **
  ** pixel move per millisecond
  **
  Float? speed

  Int relativeX := 0
  Int relativeY := 0

  Int pointerId := 0


  new make(Int type)
  {
    this.type = type
  }

  const static Int pressed := 0
  const static Int released := 1
  //dragMove
  const static Int moved := 2
  const static Int longPressed := 3
  const static Int clicked := 4
  const static Int cancel := 5
  const static Int wheel := 6
  const static Int other := 7
  const static Int mouseMove := 8
  const static Int mouseOut := 9

  override Str toStr()
  {
    super.toStr + ", MotionEvent: x:$x, y:$y, key:$key, count:$count, button:$button"
  }
}