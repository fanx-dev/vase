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

class FwtTestView : View
{
  override Void paint(Graphics2 g)
  {
    g.drawOval(10, 10, 10, 10)
  }
}
class FwtViewTest : Test
{
  Void test()
  {
    Actor.locals["fan3dTouch.NativeViewFactory"] = FwtViewFactory()
    FwtTestView.make.show(Size(500, 500))
  }
}
