//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d


@Js
class InsetLayout : Layout
{
  Int top := 12
  Int right := 12
  Int bottom := 12
  Int left := 12

  override Void relayout(WidgetGroup widget)
  {
    ContentPane pane := widget
    pane.content.size = pane.content.prefSize(widget.size)
    pane.content.pos = Point(left, top)
    pane.content.relayout
  }

  override Size prefSize(WidgetGroup widget, Size? hints)
  {
    ContentPane pane := widget
    pref := pane.content.prefSize(hints)
    return Size(pref.w + left + right, pref.h + top + bottom)
  }
}

