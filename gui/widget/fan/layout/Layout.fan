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
  abstract Void layoutChildren(WidgetGroup widget)
  abstract Size prefSize(WidgetGroup widget, Int hintsWidth := -1, Int hintsHeight := -1)
}

@Js
class FixedLayout : Layout
{
  override Void layoutChildren(WidgetGroup widget)
  {
    widget.each |c|
    {
      c.size = c.prefSize(widget.size.w, widget.size.h)
      c.relayout
    }
  }

  override Size prefSize(WidgetGroup widget, Int hintsWidth := -1, Int hintsHeight := -1)
  {
    return widget.size
  }
}

