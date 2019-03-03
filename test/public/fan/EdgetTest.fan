//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasFwt
using fanvasWindow
using fanvasGui
using fanvasMath
using fanvasArray

**
** EdgeTest
**
@Js
class EdgeTest : BaseTestWin
{
  protected override Widget build() {
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
            MessageBox { it.label.text = "hello world" }.show(root)
          }
        },
      },
    }


    mainView := EdgePane
    {
      top = menu

      left = TreeView { model = FileTreeModel() }

      center = TextArea { model = DefTextAreaModel(
                                         """
                                            //
                                            // Copyright (c) 2011, chunquedong
                                            // Licensed under the Academic Free License version 3.0
                                            //



                                            // History:
                                            //   2011-7-4  Jed Young  Creation
                                            //

                                            """)}
    }

    return mainView
  }

}