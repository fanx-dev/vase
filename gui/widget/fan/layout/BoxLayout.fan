//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d

@Js
class BoxLayout : Layout
{
  Int top := 0
  Int right := 0
  Int bottom := 0
  Int left := 0

  Int spacing := 0

  Bool orientationV := true
  Bool keepSize := false

  override Void layoutChildren(WidgetGroup widget)
  {
    Int x := top
    Int y := left
    Int hintsW := widget.size.w - (left+right)
    Int hintsH := widget.size.h - (top+bottom)

    widget.each |c|
    {
      csize := c.prefSize(hintsW, hintsH)

      if (orientationV)
      {
        c.pos = Point(left, y)
        if (keepSize)
          c.size = csize
        else
          c.size = Size(hintsW, csize.h)
        y += csize.h + spacing
      }
      else
      {
        c.pos = Point(x, top)
        if (keepSize)
          c.size = csize
        else
          c.size = Size(csize.w, hintsH)
        x += csize.w + spacing
      }

      c.relayout
    }

  }

  override Size prefSize(WidgetGroup widget, Int hintsWidth := -1, Int hintsHeight := -1)
  {
    Int hintsW := hintsWidth == -1 ? -1 : hintsWidth - (left+right)
    Int hintsH := hintsHeight == -1 ? -1 : hintsHeight - (top+bottom)
    Int w := 0
    Int h := 0
    widget.each |c, i|
    {
      size := c.prefSize(hintsW, hintsH)
      if (orientationV)
      {
        w = w.max(size.w)
        h += size.h
        if (i > 0) h += spacing
      }
      else
      {
        h = h.max(size.h)
        w += size.w
        if (i > 0) w += spacing
      }
    }

    w = w + left+right
    h = h + top+bottom
    return Size(w, h)
  }
}