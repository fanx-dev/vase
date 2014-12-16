//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

@Js
class TreeStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {

    TreeView tree := widget
    Int start := tree.offsetY / tree.rowHeight
    Int topOffset := tree.offsetY - (start * tree.rowHeight)
    Int fontOffset := tree.font.ascent + tree.font.leading
    
    g.brush = brush
    g.font = tree.font
    Int y := -topOffset + widget.padding.top
    Int bottomLine := tree.height - tree.padding.bottom
    for (i := start; i< tree.items.size; ++i)
    {
      x := tree.items[i].level * tree.indent - tree.offsetX + widget.padding.left
      
      drawItem(g, x, y + fontOffset, tree.items[i].text)
      
      y += tree.rowHeight
      if (y > bottomLine) {
//        echo("topOffset$topOffset")
        break
      }
    }
  }

  protected virtual Void drawItem(Graphics g, Int x, Int y, Str text)
  {
    //backgound

    //text
    g.drawText("- "+text, x, y)
  }
}