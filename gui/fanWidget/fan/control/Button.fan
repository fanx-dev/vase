//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

class Button : ButtonBase
{
  Label label

  new make()
  {
    style = ButtonStyle()
    label = Label { text := "button" }
    this.add(label)
  }
}