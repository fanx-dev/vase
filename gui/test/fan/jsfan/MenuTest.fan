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
** MenuTest
**
@Js
class MenuTest
{
  Void main()
  {
    ToolkitEnv.init
    RootView? view
    view = RootView
    {
      Menu
      {
        MenuItem
        {
          it.text = "File"
          addItem( MenuItem
          {
            it.text = "Open"
            addItem( MenuItem{it.text = "From 1"} )
            addItem( MenuItem{it.text = "From 2"} )
          })
          addItem( MenuItem
          {
            it.text = "Save"
            addItem( MenuItem{it.text = "as 1"} )
            addItem( MenuItem{it.text = "as 2"} )
          })
        },
        MenuItem
        {
          it.text = "Edit"
          addItem( MenuItem{it.text = "Copy"} )
          addItem( MenuItem{it.text = "Paste"} )
        },
        MenuItem
        {
          it.text = "Help"
          addItem( MenuItem
          {
            it.text = "About"
            it.onAction.add
            {
              MessageBox { it.label.text = "hello world" }.show(view)
            }
          })
        },
      },
    }

    view.size = Size(600, 600)
    view.show
  }
}