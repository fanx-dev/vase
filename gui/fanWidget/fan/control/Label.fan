//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanWt
using fan2d

class Label : Widget
{
  Str text := ""

  new make()
  {
    style = LabelStyle()
  }
}