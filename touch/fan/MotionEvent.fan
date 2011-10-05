//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using gfx

@Js
class MotionPointer
{
  const Point pos
  const Float? pressure
  const Float? size
  const Int action
  
  new make(|This| f){ f(this) }
}

@Js
enum class ActionType
{
  down, move, up
}

@Js
class MotionEvent : Event
{
  private MotionPointer[] pointers
  const ActionType action
  
  new make(MotionPointer[] pointers, ActionType action)
  {
    this.pointers = pointers
    this.action = action
  }
  
  Float? pressure(Int i := 0) { pointers[i].pressure }
  Float? size(Int i := 0) { pointers[i].size }
  Point pos(Int i := 0) { pointers[i].pos }
  
  Int count() { pointers.size }
}
