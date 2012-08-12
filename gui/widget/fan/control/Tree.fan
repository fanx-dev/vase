//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class ScrollTree : ScrollPane
{
  Tree tree := Tree()

  new make(TreeModel? model)
  {
    this.add(tree)
    tree.model = model
    tree.initFromModel
  }
}

**
** Tree
**
@Js
class Tree : WidgetGroup
{
  **
  ** Backing data model of tree.
  **
  TreeModel? model := null

  new make()
  {
    layout = VBox()
  }

  **
  ** Update the entire tree's contents from the model.
  **
  Void initFromModel()
  {
    if (model == null) return
    this.removeAll
    model.roots.each |subNode|
    {
      tnode := TreeNode{}
      this.add(tnode)
      tnode.model = model
      tnode.node = subNode
      tnode.item.text = model.text(subNode)
    }
  }
}

**************************************************************************
** TreeNode
**************************************************************************

@Js
class TreeNode : WidgetGroup
{
  Button item := Button()

  TreeModel? model := null
  Obj? node := null

  Bool isExpanded := false

  ScrollTree? rootTree()
  {
    Widget? x := this
    while (x != null)
    {
      if (x is ScrollTree) return (ScrollTree)x
      x = x.parent
    }
    return null
  }

  new make()
  {
    item.styleClass = "treeNodeItem"
    item.onAction.add
    {
      if (model != null)
      {
        if (isExpanded)
        {
          this.removeAll
          this.doAdd(item)
          isExpanded = false
        }
        else
        {
          initFromModel()
        }
        rootTree.relayout
        rootTree.repaint
      }
    }
    super.add(item)
    layout = VBox()
  }

  @Operator
  override This add(Widget child)
  {
    super.add(child)
    child.pos = Point(child.pos.x+10, child.pos.y)
    return this
  }

  private Void doAdd(Widget child) { super.add(child) }

  Bool hasChildren()
  {
    if (model != null) return model.hasChildren(node)
    else return false
  }

  Void initFromModel()
  {
    this.removeAll
    super.add(item)

    if (model.hasChildren(node))
    {
      model.children(node).each |subNode|
      {
        tnode := TreeNode{}
        this.add(tnode)
        tnode.model = model
        tnode.node = subNode
        tnode.item.text = model.text(subNode)
      }
    }
    isExpanded = true
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