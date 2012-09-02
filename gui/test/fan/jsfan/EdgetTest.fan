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
** EdgeTest
**
@Js
class EdgeTest
{
  Void main()
  {
    ToolkitEnv.init

    view := RootView
    {
      ContentPane
      {
        layout = FillLayout()
        EdgePane
        {
          top = WidgetGroup
          {
            layout = BoxLayout { orientationV = false }

            Button { text = "Hello1" },
            Button { text = "Hello2" },
            Button { text = "Hello3" },
            Button { text = "Hello4" },
            Button { text = "Hello5" },
          }

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
      },
    }

    view.size = Size(600, 600)
    view.show
  }

}