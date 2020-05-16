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
  Color dropColor := Color(0xf04455)
  
  override Void doPaint(Widget widget, Graphics g)
  {

    TreeView tree := widget
    Int start := tree.offsetY / tree.rowHeight
    Int topOffset := tree.offsetY - (start * tree.rowHeight)
    Int fontOffset := font.ascent + font.leading
    top := widget.paddingTop
    left := widget.paddingLeft
    bottom := dpToPixel(widget.padding.bottom)
    
    //g.brush = Color.red
    //g.fillRect(widget.x, widget.y, widget.width, widget.height)

    g.brush = fontColor
    g.font = font
    Int y := -topOffset + top
    Int bottomLine := tree.height - bottom
    treeX := - tree.offsetX + left
    for (i := start; i< tree.items.size; ++i)
    {
      if (i >= 0) {
        item := tree.items[i]
        x := item.level * dpToPixel(tree.indent) + treeX

        drawItem(g, item, tree, treeX, x, y, fontOffset)
      }
      y += tree.rowHeight
      if (y > bottomLine) {
//        echo("topOffset$topOffset")
        break
      }
    }
  }

  protected virtual Void drawItem(Graphics g, TreeItem item
    , TreeView tree, Int treeX, Int itemX, Int itemY, Int fontOffset)
  {
    //backgound
    if (item === tree.selectedItem) {
       g.brush = color
       g.fillRect(treeX, itemY, tree.contentWidth, tree.rowHeight)
       g.brush = fontColor
    }
    else if (item === tree.dragDropItem) {
       g.brush = dropColor
       g.fillRect(treeX, itemY, tree.contentWidth, tree.rowHeight)
       g.brush = fontColor
    }

    //text
    text := item.text
    if (item.hasChildren) {
      if (item.expanded) text = "v " + text
      else text = "> " + text
      g.drawText(text, itemX, itemY+fontOffset)
    } else {
      g.drawText("  "+text, itemX, itemY+fontOffset)
    }
  }
}