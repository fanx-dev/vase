//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.fanWt;

import javax.swing.*;
import fan.concurrent.Actor;


public class ToolkitEnvPeer
{
  public static ToolkitEnvPeer make(ToolkitEnv self)
  {
    ToolkitEnvPeer peer = new ToolkitEnvPeer();
    return peer;
  }

  public static void init()
  {
    Actor.locals().set("fan2d.env", AwtGfxEnv.instance);
    Actor.locals().set("fanWt.env", new AwtToolkit());
  }

  static class AwtToolkit extends Toolkit
  {
    public Window build(View view)
    {
      return new AwtWindow(view);
    }
  }
}