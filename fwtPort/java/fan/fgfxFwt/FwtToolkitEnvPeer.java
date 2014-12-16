//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.fgfxFwt;

import fan.concurrent.Actor;
import fan.fgfxGraphics.Graphics;
import fan.sys.*;

public class FwtToolkitEnvPeer
{
  public static FwtToolkitEnvPeer make(FwtToolkitEnv self)
  {
    FwtToolkitEnvPeer peer = new FwtToolkitEnvPeer();
    return peer;
  }

  public static void initGfxEnv()
  {
    Actor.locals().set("fgfxGraphics.env", SwtGfxEnv.instance);
  }

  public static Graphics toGraphics(fan.gfx.Graphics fg)
  {
    fan.fwt.FwtGraphics fwt = (fan.fwt.FwtGraphics)fg;
    return new SwtGraphics(fwt.gc());
  }
}