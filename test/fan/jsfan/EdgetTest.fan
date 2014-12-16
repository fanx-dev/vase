//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfxGraphics
using fgfxFwt
using fgfxWtk
using fgfxWidget
using fgfxMath
using fgfxArray

**
** EdgeTest
**
@Js
class EdgeTest
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

    RootView? view
    menu := Menu
    {
      MenuItem
      {
        it.text = "File"
        MenuItem
        {
          it.text = "Open"
          MenuItem{it.text = "From 1"},
          MenuItem{it.text = "From 2"},
        },
        MenuItem
        {
          it.text = "Save"
          MenuItem{it.text = "as 1"},
          MenuItem{it.text = "as 2"},
        },
      },
      MenuItem
      {
        it.text = "Edit"
        MenuItem{it.text = "Copy"},
        MenuItem{it.text = "Paste"},
      },
      MenuItem
      {
        it.text = "Help"
        MenuItem
        {
          it.text = "About"
          it.onAction.add
          {
            MessageBox { it.label.text = "hello world" }.show(view)
          }
        },
      },
    }

    view = RootView
    {
      EdgePane
      {
        top = menu

        left = TreeView(FileTreeModel())

        center = TextArea(DefTextAreaModel("""
                                              //
                                              // Copyright (c) 2011, chunquedong
                                              // Licensed under the Academic Free License version 3.0
                                              //



                                              // History:
                                              //   2011-7-4  Jed Young  Creation
                                              //

                                              """))
      },
    }

    view.show
  }

}