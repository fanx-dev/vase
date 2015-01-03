//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfxGraphics
using concurrent

**
** Window is a host display
**
@Js
mixin Window
{
  **
  ** add a view to window
  **
  abstract This add(View view)

  **
  ** remvoe view
  **
  abstract Void remove(View view)

  **
  ** open this window. size is options
  **
  abstract Void show(Size? size := null)
}

