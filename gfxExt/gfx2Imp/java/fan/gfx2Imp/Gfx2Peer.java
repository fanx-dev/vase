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
  private static FwtEnv fwtEnv;
  static FwtEnv getFwtEnv()
  {
    if (fwtEnv == null)
    {
      fwtEnv = FwtEnv.make();
    }
    return fwtEnv;
  }

  public static Gfx2Peer make(Gfx2 self) { return new Gfx2Peer(); }

  static public GfxEnv getEngine(String name)
  {
    if (name.equals("AWT")) return AwtGfxEnv.instance;
    else if (name.equals("SWT")) return getFwtEnv();
    else if (name.equals("Android")) return AndGfxEnv.instance;
    else throw UnsupportedErr.make();
  }

  static public GfxEnv2 getEngine2(String name)
  {
    if (name.equals("AWT")) return AwtGfxEnv2.instance;
    else if (name.equals("SWT")) return FwtEnv2.instance;
    else if (name.equals("Android")) return AndGfxEnv2.instance;
    else throw UnsupportedErr.make();
  }

}