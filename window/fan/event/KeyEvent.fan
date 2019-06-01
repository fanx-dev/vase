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
** KeyEvent
**
@Js
class KeyEvent : Event
{
  **
  ** Unicode character represented by a key event.
  **
  Int? keyChar

  **
  ** Key code and modifiers.
  **
  Key? key

  new make(Int type)
  {
    this.type = type
  }

  override Str toStr()
  {
    super.toStr + ", KeyEvent: key:$key, keyChar:$keyChar.toChar"
  }

  const static Int pressed := 9
  const static Int released := 10
  const static Int typed := 11
}