//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using vaseGraphics
using vaseWindow


**
** TreeView
**
@Js
class TreeView : ScrollPane
{
  **
  ** Backing data model of tree.
  **
  @Transient
  TreeModel model := TreeModel() {
    set { &model = it; init }
  }

  @Transient
  internal TreeItem[] items := [,]
  
  TreeItem? selectedItem
  TreeItem? dragDropItem
  private Bool draging := false

  Int rowHeight() { font.height }

  private Font font() {
    getStyle.font
  }

  Int minWidth := 600
  Int indent := 60

  **
  ** Default constructor.
  **
  new make(|This|? f := null)
  {
    if (f != null) f(this)
    super.autoScrollContent = false
  }

  protected override Float contentMaxWidth() {
    Int w := dpToPixel(minWidth)
    Int indent := dpToPixel(this.indent)
    items.each {
      x := it.level * indent + font.width("- "+it.text)
      if (w < x) {
        w = x
      }
    }
    return w.toFloat
  }

  protected override Size prefContentSize() {
    Int w := dpToPixel(minWidth)
    Int h := items.size * rowHeight
    return Size(w, h)
  }

  Void expanded(TreeItem item)
  {
    if (!item.hasChildren) return

    if (item.expanded)
    {
      //close
      i := items.indexSame(item) + 1
      start := i
      for (n := items.size; i<n; ++i)
      {
        if (items[i].level <= item.level) break
      }
      items.removeRange((start..<i))
      item.expanded = !item.expanded
      return
    }
    else
    {
      //expand
      i := items.indexSame(item)
      items.insertAll(i+1, item.children)
      item.expanded = !item.expanded
      return
    }
  }

  **
  ** Update the entire tree's contents from the model.
  **
  private Void init()
  {
    items.clear
    model.roots.each |subNode|
    {
      item := TreeItem(this, subNode, 0)
      items.add(item)
    }
  }
  
  protected override Void motionEvent(MotionEvent e) {
    super.motionEvent(e)
    
    if (e.type == MotionEvent.pressed) {
        item := findItemAt(e.relativeY)
        if (selectedItem == item) {
            draging = true
            dragDropItem = null
        }
    }
  }
  
  private TreeItem? findItemAt(Int eventY) {
    sy := eventY - y
    Int i := (offsetY + sy) / rowHeight
    if (i < items.size) {
        return items[i]
    }
    else {
        return null
    }
  }

  protected override Void gestureEvent(GestureEvent e)
  {
    if (e.type == GestureEvent.click)
    {
      item := findItemAt(e.relativeY)
      if (item != null)
      {
        expanded(item)
        this.relayout
        e.consume
      }
      selectedItem = item
      dragDropItem = null
    }
    
    if (e.consumed) return
    if (!draging) {
      super.gestureEvent(e)
      return
    }
    
    if (e.type == GestureEvent.drag) {
      dragDropItem = findItemAt(e.relativeY)
      e.consume
      this.repaint
    }
    else if (e.type == GestureEvent.drop || e.type == GestureEvent.fling) {
      draging = false
      dragDropItem = findItemAt(e.relativeY)
      model.onDragDrop(selectedItem, dragDropItem)
      dragDropItem = null
      this.relayout
      e.consume
    }
  }
}

**************************************************************************
** TreeItem
**************************************************************************

@Js
class TreeItem
{
  @Transient
  private TreeView tree

  Obj node

  Str text() { tree.model.text(node) }
  Int level := 0
  Bool expanded := false

  new make(TreeView tree, Obj node, Int level)
  {
    this.tree = tree
    this.node = node
    this.level = level
  }

  Bool hasChildren() { tree.model.hasChildren(node) }

  TreeItem[] children()
  {
    list := TreeItem[,]
    tree.model.children(node).each |subNode|
    {
      item := TreeItem(tree, subNode, level+1)
      list.add(item)
    }
    return list
  }
}

**************************************************************************
** TreeModel
**************************************************************************

**
** TreeModel models the data of a tree widget.
**
@Js
class TreeModel
{
  **
  ** Get root nodes.
  **
  virtual Obj[] roots() { [,] }

  **
  ** Get the text to display for specified node.
  ** Default is 'node.toStr'.
  **
  virtual Str text(Obj node) { node.toStr }

  **
  ** Get the image to display for specified node or null.
  **
  virtual Image? image(Obj node) { null }

  **
  ** Return if this has or might have children.  This
  ** is an optimization to display an expansion control
  ** without actually loading all the children.  The
  ** default returns '!children.isEmpty'.
  **
  virtual Bool hasChildren(Obj node) { !children(node).isEmpty }

  **
  ** Get the children of the specified node.  If no children
  ** return an empty list.  Default behavior is no children.
  **
  virtual Obj[] children(Obj node) { List.defVal }
  
  
  virtual Void onDragDrop(Obj from, Obj to) {}

}

**************************************************************************
** FileTreeModel
**************************************************************************

class FileTreeModel : TreeModel
{
  override File[] roots := File.osRoots
  override Str text(Obj node) { return (node as File).name }
  override Bool hasChildren(Obj node) { return ((File)node).isDir }
  override Obj[] children(Obj node) { return ((File)node).list }
}