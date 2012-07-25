//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanWt
using fan2d

class ToggleButton : ButtonBase
{
  Bool selected := false
  {
    set
    {
      e := StateChangedEvent (&selected, it, #selected, this )
      onStateChanged.fire(e)
      &selected = it
    }
  }

  new make()
  {
    onAction.add { selected = !selected }
  }
}