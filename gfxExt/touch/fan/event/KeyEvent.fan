//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

@Js
class KeyEvent : Event
{
  const Str keyChar
  const Int keyCode
  const Bool isDown
  const Int modifiers

  new make(|This| f) { f(this) }
}