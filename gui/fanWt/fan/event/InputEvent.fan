//
// Copyright (c) 2009-2011, chunquedong
//
// This file is part of ChunMap project
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE version 3.0
//
// History:
//   2011-05-05  Jed Young  Creation
//


**
** InputEvent
**
@Js
class InputEvent : Event
{

  Int? x
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
  ** Unicode character represented by a key event.
  **
  Int? keyChar

  **
  ** Key code and modifiers.
  **
  Key? key


  InputEventType? type
  Obj? rawEvent

  new make(Int id)
  {
    this.id = id
    switch(id)
    {
    case mouseDown:
    case keyDown:
      type = InputEventType.press
    case mouseUp:
    case keyUp:
      type = InputEventType.release
    case mouseMove:
      type = InputEventType.move
    default:
      type = InputEventType.other
    }
  }

  const static Int mouseDown := 0
  const static Int mouseUp := 1
  const static Int mouseMove := 2
  const static Int mouseWheel := 3
  const static Int mouseEnter := 4
  const static Int mouseExit := 5
  const static Int mouseHover := 6
  const static Int keyDown := 7
  const static Int keyUp := 8
  const static Int touchEvent := 9
  const static Int keyTyped := 10
}

**
** Event Type
**
@Js
enum class InputEventType
{
  press,
  release,
  move,
  longPress,
  other
}