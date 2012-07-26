//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-23  Jed Young  Creation
//

using fgfx2d
using fgfxWtk
using concurrent

mixin Animation
{
  abstract Void trans(Widget w)
}

class Transition : Animation
{
  override Void trans(Widget w)
  {
    t := Timer()
    Int d := 2
    Int x := w.pos.x
    t.delay = 40
    t.onTimeOut = |->|
    {
      w.repaint
      w.pos = Point(w.pos.x + d, w.pos.y)
      if (w.pos.x > 400) w.pos = Point(x, w.pos.y)
      w.repaint
    }
    w.rootView.onOpened.add { t.start }
  }
}