//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

@Js
class StateChangedEvent : Event
{
  Obj? oldValue
  Obj? newValue
  const Field? field

  new make(Obj? oldValue, Obj? newValue, Field? field, Obj? src)
  {
    this.oldValue = oldValue
    this.newValue = newValue
    this.field = field
    this.src = src
  }

  override Str toStr()
  {
    "old: $oldValue, new: $newValue"
  }
}