//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfx2d
using fgfxWtk
using fgfxWidget

**
** TreeTest
**
@Js
class TreeTest
{
  Void main()
  {
    ToolkitEnv.init

    view := RootView
    {
      ScrollTree(MyTreeModel()),
    }

    view.size = Size(600, 600)
    view.show
  }
}

@Js
class MyTreeModel : TreeModel
{
  override Obj[] roots()
  {
    ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  }
  override Str text(Obj node) { node.toStr }
  override Bool hasChildren(Obj node) { true }
  override Obj[] children(Obj node) { ["a", "b", "c", "d", "e", "f"] }
}