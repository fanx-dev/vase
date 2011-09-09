//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//

package fan.gfx2Imp;

import fan.sys.*;
import fan.fwt.*;
import fan.gfx.*;
import fan.gfx2.*;

public class Gfx2Peer
{
  static AwtGfxEnv awtEnv = new AwtGfxEnv();
  static AwtGfxEnv2 awtEnv2 = new AwtGfxEnv2();

  static FwtEnv fwtEnv = FwtEnv.make();
  static FwtEnv2 fwtEnv2 = FwtEnv2.singleton;

  public static Gfx2Peer make(Gfx2 self) { return new Gfx2Peer(); }

  static public GfxEnv getEngine(String name)
  {
    if (name.equals("AWT")) return awtEnv;
    else if (name.equals("SWT")) return fwtEnv;
    else throw UnsupportedErr.make();
  }

  static public GfxEnv2 getEngine2(String name)
  {
    if (name.equals("AWT")) return awtEnv2;
    else if (name.equals("SWT")) return fwtEnv2;
    else throw UnsupportedErr.make();
  }

}