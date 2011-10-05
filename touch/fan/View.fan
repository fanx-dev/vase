//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using gfx
using gfx2
using concurrent

@Js
class View : Widget
{
  protected NativeView nativeView
  
  new make()
  {
    nativeView = NativeView.build(this)
  }
  
  Void show(Size? size := null) { nativeView.show(size) }
}