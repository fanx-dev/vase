//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d


@Js
class FillLayout : Layout
{
  override Void layoutChildren(WidgetGroup widget)
  {
    ContentPane pane := widget
    pane.content.size = widget.size
    pane.content.relayout
  }

  override Size prefSize(WidgetGroup widget, Int hintsWidth := -1, Int hintsHeight := -1)
  {
    ContentPane pane := widget
    pref := pane.content.prefSize(hintsWidth, hintsHeight)
    return Size(pref.w.max(hintsWidth), pref.h.max(hintsHeight))
  }
}

