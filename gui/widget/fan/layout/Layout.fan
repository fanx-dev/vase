//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d

@Js
mixin Layout
{
  abstract Void relayout(WidgetGroup widget)
  abstract Size prefSize(WidgetGroup widget, Size? hints)
}

@Js
class FixedLayout : Layout
{
  override Void relayout(WidgetGroup widget)
  {
    widget.each |c|
    {
      c.size = c.prefSize(widget.size)
      c.relayout
    }
  }

  override Size prefSize(WidgetGroup widget, Size? hints)
  {
    return widget.size
  }
}

