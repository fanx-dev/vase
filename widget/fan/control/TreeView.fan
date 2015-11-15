//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk


**
** TreeView
**
@Js
class TreeView : ScrollBase
{
  **
  ** Backing data model of tree.
  **
  TreeModel model
  internal TreeItem[] items := [,]
  Int rowHeight { private set }
  Font font {
    set { rowHeight = it.height; &font = it; }
  }
  Int indent := dpToPixel(60f)

  new make(TreeModel model)
  {
    this.model = model
    font = Font(dpToPixel(41f))
    init
  }

  protected override Int contentMaxWidth(Dimension result) {
    Int w := dpToPixel(600f)
    items.each {
      x := it.level * indent + font.width("- "+it.text)
      if (w < x) {
        w = x
      }
    }
    return w
  }

  protected override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    Int w := dpToPixel(600f)
    Int h := items.size * rowHeight
    return result.set(w, h)
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
    model.roots.each |subNode|
    {
      item := TreeItem(this, subNode, 0)
      items.add(item)
    }
  }

  protected override Void gestureEvent(GestureEvent e)
  {
    super.gestureEvent(e)
    if (e.consumed) return
    sy := e.relativeY - y
    if (e.type == GestureEvent.click)
    {
      Int start := offsetY / rowHeight
      Int ti := sy / rowHeight
      Int i := start + ti

      if (i < items.size)
      {
        expanded(items[i])
        this.layout
        e.consume
      }
    }
  }
}

**************************************************************************
** TreeItem
**************************************************************************

@Js
class TreeItem
{
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
  virtual Obj[] children(Obj node) { Obj#.emptyList }

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