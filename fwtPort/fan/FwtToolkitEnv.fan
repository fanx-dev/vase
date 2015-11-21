//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fanvasGraphics
using concurrent
using fanvasWindow

**
** Toolkit
**
@Js
const class FwtToolkit : Toolkit
{
  override Window build()
  {
    return FwtWindow()
  }

  override Str name() { "SWT" }

  override Void callLater(Int delay, |->| f)
  {
    fwt::Desktop.callLater(Duration(delay*1000000), f)
  }
}

**
** Default Toolkit maker
**
@Js
class FwtToolkitEnv
{
  static Void init()
  {
    initGfxEnv
    Actor.locals["fanvasWindow.env"] = FwtToolkit()
  }

  private native static Void initGfxEnv()
  native static Graphics toGraphics(gfx::Graphics fg)
}