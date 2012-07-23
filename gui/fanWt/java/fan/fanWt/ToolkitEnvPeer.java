//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.fanWt;

import javax.swing.*;
import java.awt.*;
import fan.concurrent.Actor;
import fan.sys.*;


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

    public void callLater(final long delay, final Func f)
    {
      new Thread()
      {
        public void start()
        {
          try
          {
            Thread.sleep(delay);
          }
          catch (InterruptedException e)
          {
            e.printStackTrace();
          }

          EventQueue.invokeLater(new Runnable()
          {
            public void run()
            {
              f.call();
            }
          });
        }
      }.start();

    }
  }
}