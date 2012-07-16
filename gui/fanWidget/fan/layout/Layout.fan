//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fan2d

@Js
mixin Layout
{
  abstract Void relayout(Widget widget)
  abstract Size prefSize(Widget widget, Size? hints)
}

@Js
class FixedLayout : Layout
{
  override Void relayout(Widget widget)
  {
    widget.each |c|
    {
      c.size = c.prefSize(widget.size)
      c.relayout
    }
  }

  override Size prefSize(Widget widget, Size? hints)
  {
    return widget.size
  }
}

