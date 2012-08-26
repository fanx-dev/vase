//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d

@Js
class HBoxLayout : Layout
{
  override Void relayout(WidgetGroup widget)
  {
    Int w := 0
    Int h := 0
    widget.each |c|
    {
      c.size = c.prefSize(widget.size)
      c.relayout
      csize := c.size
      if (csize.h > h) h = csize.h
      c.pos = Point(w, c.pos.y)
      w += csize.w
    }

  }

  override Size prefSize(WidgetGroup widget, Size? hints)
  {
    Int w := -1
    Int h := -1
    widget.each |c|
    {
      csize := c.prefSize(hints)
      if (csize.h > h) h = csize.h
      w += csize.w
    }
    if (w == -1) w = widget.size.w
    if (h == -1) h = widget.size.h
    return Size(w, h)
  }
}

@Js
class VBoxLayout : Layout
{
  override Void relayout(WidgetGroup widget)
  {
    Int w := 0
    Int h := 0
    widget.each |c|
    {
      c.size = c.prefSize(widget.size)
      c.relayout
      csize := c.size
      if (csize.w > w) w = csize.w
      c.pos = Point(c.pos.x, h)
      h += csize.h
    }
  }

  override Size prefSize(WidgetGroup widget, Size? hints)
  {
    Int w := 0
    Int h := 0
    widget.each |c|
    {
      csize := c.prefSize(widget.size)
      if (csize.w+c.pos.x > w) w = csize.w+c.pos.x
      h += csize.h
    }
    return Size(w, h)
  }
}