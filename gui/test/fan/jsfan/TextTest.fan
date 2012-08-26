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
** TextTest
**
@Js
class TextTest
{
  Void main()
  {
    ToolkitEnv.init

    view := RootView
    {
      TextArea(DefTextAreaModel("""
                                    //
                                    // Copyright (c) 2011, chunquedong
                                    // Licensed under the Academic Free License version 3.0
                                    //



                                    // History:
                                    //   2011-7-4  Jed Young  Creation
                                    //

                                    """)),
    }

    view.size = Size(600, 600)
    view.show
  }
}