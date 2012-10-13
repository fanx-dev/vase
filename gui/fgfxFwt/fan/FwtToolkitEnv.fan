//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfx2d
using concurrent

**
** Default Toolkit maker
**
@Js
class FwtToolkitEnv
{
  static Void init()
  {
    initGfxEnv
  }

  private native static Void initGfxEnv()
  native static Graphics toGraphics(gfx::Graphics fg)
}