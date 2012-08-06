//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fgfx2d


**
** Mouse event or Touch event
**
@Js
class MotionEvent : Event
{
  **
  ** X coordinates
  **
  Int? x

  **
  ** Y coordinates
  **
  Int? y

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
  ** native event
  **
  Obj? rawEvent

  **
  ** For muilt touch event
  **
  MotionEvent[]? pointers


  new make(Int id)
  {
    this.id = id
  }

  const static Int pressed := 0
  const static Int released := 1
  const static Int moved := 2
  const static Int longPressed := 3
  const static Int other := 4
  const static Int clicked := 5

  override Str toStr()
  {
    super.toStr + "MotionEvent: x:$x, y:$y, key:$key, count:$count, button:$button"
  }
}