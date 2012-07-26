//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fgfx2d

@Js
class MotionPointer
{
  const Point pos
  const Float? pressure
  const Float? size
  const MotionAction action

  new make(|This| f){ f(this) }

  override Str toStr()
  {
    "pos: $pos, action: $action, pressure: $pressure, size: size"
  }
}

@Js
enum class MotionAction
{
  down, move, up, none
}

@Js
class MotionEvent : Event
{
  private MotionPointer[] pointers

  new make(MotionPointer[] pointers)
  {
    this.pointers = pointers
  }

  Float? pressure(Int i := 0) { pointers[i].pressure }
  Float? size(Int i := 0) { pointers[i].size }
  Point pos(Int i := 0) { pointers[i].pos }

  Bool isDown(Int i:=0) { pointers[i].action == MotionAction.down }
  Bool isMove(Int i:=0) { pointers[i].action == MotionAction.move }
  Bool isUp(Int i:=0) { pointers[i].action == MotionAction.up }

  Int count() { pointers.size }

  override Str toStr()
  {
    pointers.toStr
  }
}