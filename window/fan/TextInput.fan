//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fanvasGraphics
using concurrent

**
** root view
**
@Js
mixin TextInput
{
  abstract TextInputPeer? host

  const static Int inputTypeText := 1
  const static Int inputTypeIntNumber := 2
  const static Int inputTypeFloatNumber := 3
  const static Int inputTypePassword := 4

  abstract Point getPos()
  abstract Size getSize()

  abstract Int inputType()
  abstract Bool singleLine()
  abstract Bool selectable()

  abstract Color textColor()
  abstract Color backgroundColor()
  abstract Font font()
  
  abstract Str text()

  abstract Void willTextChange(Str text)
  abstract Void didTextChange(Str text)
}

@Js
mixin TextInputPeer
{
  abstract Void close()
  abstract Void update()
}
