//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfxGraphics
using fgfxWtk
using fgfxWidget
using fgfxFwt

**
** TreeTest
**
@Js
class TreeTest
{
  Bool initEnv() {
    if (Env.cur.runtime != "java") {
      ToolkitEnv.init
      return true
    }
    if (Env.cur.args.size > 0) {
      if (Env.cur.args.first == "AWT") {
        ToolkitEnv.init
        return true
      }
      else if (Env.cur.args.first == "SWT") {
        FwtToolkitEnv.init
        return true
      }
    }
    echo("AWT or SWT ?")
    return false
  }

  Void main()
  {
    if (!initEnv) return

    view := RootView
    {
      TreeView(MyTreeModel()),
    }

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
  override Obj[] children(Obj node) { ["aaa", "bbb", "ccc", "ddd", "eee", "fff"] }
}