//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class TreeStyle : WidgetStyle
{
  override Void doPaint(Widget widget, Graphics g)
  {

    TreeView tree := widget
    Int start := tree.offsetY / tree.rowHeight
    Int topOffset := tree.offsetY - (start * tree.rowHeight)
    Int fontOffset := font.ascent + font.leading
    top := widget.paddingTop
    left := widget.paddingLeft
    bottom := dpToPixel(widget.padding.bottom.toFloat)

    g.brush = fontColor
    g.font = font
    Int y := -topOffset + top
    Int bottomLine := tree.height - bottom
    for (i := start; i< tree.items.size; ++i)
    {
      item := tree.items[i]
      x := item.level * dpToPixel(tree.indent) - tree.offsetX + left

      drawItem(g, x, y + fontOffset, item.text, item)

      y += tree.rowHeight
      if (y > bottomLine) {
//        echo("topOffset$topOffset")
        break
      }
    }
  }

  protected virtual Void drawItem(Graphics g, Int x, Int y, Str text, TreeItem item)
  {
    //backgound

    //text
    if (item.hasChildren) {
       g.drawText("- "+text, x, y)
    } else {
       g.drawText("  "+text, x, y)
    }
  }
}