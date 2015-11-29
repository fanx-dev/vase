//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasWindow
using fanvasGui
using fanvasFwt

**
** TextTest
**
@Js
class TextTest
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
      mainView =
      TextArea(DefTextAreaModel( """//
                                    // Copyright (c) 2011, chunquedong
                                    // Licensed under the Academic Free License version 3.0
                                    //



                                    // History:
                                    //   2011-7-4  Jed Young  Creation
                                    //"""))
    }

    view.show
  }
}