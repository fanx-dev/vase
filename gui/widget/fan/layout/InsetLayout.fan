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

  override Void layoutChildren(WidgetGroup widget)
  {
    ContentPane pane := widget
    Int hintsW := widget.size.w - (left+right)
    Int hintsH := widget.size.h - (top+bottom)
    pane.content.size = Size(hintsW, hintsH)
    pane.content.pos = Point(left, top)
    pane.content.relayout
  }

  override Size prefSize(WidgetGroup widget, Int hintsWidth := -1, Int hintsHeight := -1)
  {
    ContentPane pane := widget
    Int hintsW := hintsWidth == -1 ? -1 : hintsWidth - (left+right)
    Int hintsH := hintsHeight == -1 ? -1 : hintsHeight - (top+bottom)
    pref := pane.content.prefSize(hintsW, hintsH)
    return Size(pref.w + left + right, pref.h + top + bottom)
  }
}

