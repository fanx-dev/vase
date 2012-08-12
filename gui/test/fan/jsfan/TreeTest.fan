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
      ScrollTree(FileTreeModel()),
    }

    view.size = Size(600, 600)
    view.show
  }

}