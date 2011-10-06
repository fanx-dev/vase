//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using concurrent
using gfx
using gfx2

class FwtViewTest
{
  Void main()
  {
    Actor.locals["fan3dTouch.NativeViewFactory"] = FwtViewFactory()
    
    Int i:=0
    View
    {
      size = Size(500, 500)
      Button { onAction.add { echo("Hi ${i++}") }; pos = Point(10, 10); text = "OK" },
    }.show
  }
}
