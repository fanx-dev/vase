//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class TreeStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    TreeView tree := widget
    Int start := tree.offsetY / tree.rowHeight
    Int count := tree.size.h / tree.rowHeight
    Int end := (start + count).min(tree.items.size)
    Int fontHeight := font.height

    Int c := 0
    for (i := start; i< end; ++i)
    {
      drawItem(g, tree.items[i].level * 15, fontHeight + c * tree.rowHeight, tree.items[i].text)
      ++c
    }
  }

  protected virtual Void drawItem(Graphics g, Int x, Int y, Str text)
  {
    //backgound

    //text
    g.brush = brush
    g.drawText("- "+text, x, y)
  }
}