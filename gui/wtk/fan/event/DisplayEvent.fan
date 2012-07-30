//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

**
** Windows host Event
**
@Js
class DisplayEvent : Event
{
  static const Int opened := 0
  static const Int closing := 1
  static const Int closed := 2

  static const Int deactivated := 3
  static const Int activated := 4

  static const Int deiconified := 5
  static const Int iconified := 6

  static const Int lostFocus := 7
  static const Int gainedFocus := 8

  new make(Int id)
  {
    this.id = id
  }

  override Str toStr() { "DisplayEvent: $id" }
}