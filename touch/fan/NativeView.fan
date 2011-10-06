//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using gfx
using concurrent

@NoDoc
@Js
mixin NativeView
{
  abstract Size size()
  abstract Size displaySize()
  abstract Point pos()
  abstract Void show(Size? size := null)
  abstract Void repaint(Rect? dirty := null)
  abstract Bool hasFocus()
  abstract Void focus()
  
  static NativeView build(View view)
  {
    NativeViewFactory factory := Actor.locals["fan3dTouch.NativeViewFactory"]
    return factory.build(view)
  }
}

@NoDoc
@Js
mixin NativeViewFactory
{
  abstract NativeView build(View view)
}