//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.fanvasWindow;

import java.awt.EventQueue;
import java.util.Timer;
import java.util.TimerTask;

import fan.concurrent.Actor;
import fan.sys.Func;


public class ToolkitEnvPeer
{
  public static ToolkitEnvPeer make(ToolkitEnv self)
  {
    ToolkitEnvPeer peer = new ToolkitEnvPeer();
    return peer;
  }

  public static void init()
  {
    Actor.locals().set("fanvasGraphics.env", WtkGfxEnv.instance);
    Actor.locals().set("fanvasWindow.env", AwtToolkit.instance);
  }

  public static void initMainThread() {
    EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        init();
        Toolkit.tryInitAsyncRunner();
      }
    });
  }

  static class AwtToolkit extends Toolkit
  {
    static AwtToolkit instance = new AwtToolkit();
    private WtkWindow curWindow = null;

    Timer timer = new Timer(true);
    public WtkWindow window(View view)
    {
      if (view != null) {
        curWindow = new WtkWindow(view);
        curWindow.show(null);
      }
      return curWindow;
    }

    public String name() {
      return "AWT";
    }

    public void callLater(final long delay, final Func f)
    {
      TimerTask task = new TimerTask()
      {
        public void run()
        {
          EventQueue.invokeLater(new Runnable()
          {
            public void run()
            {
              f.call();
            }
          });
        }
      };

      timer.schedule(task, delay);
    }

    private static Clipboard m_clipboard;

    public Clipboard clipboard() {
      if (m_clipboard == null) {
        m_clipboard = new Clipboard() {
          java.awt.datatransfer.Clipboard sysClipboard = java.awt.Toolkit.getDefaultToolkit().getSystemClipboard();

          public String getText(Func callback) {
              java.awt.datatransfer.Transferable trans = sysClipboard.getContents(null);
              if (trans != null) {
                  if (trans.isDataFlavorSupported(java.awt.datatransfer.DataFlavor.stringFlavor)) {
                      try {
                          String text = (String) trans.getTransferData(java.awt.datatransfer.DataFlavor.stringFlavor);
                          callback.call(text);
                          return text;
                      } catch (Exception e) {
                          e.printStackTrace();
                      }
                  }
              }
              callback.call(null);
              return null;
          }

          public void setText(String text) {
            java.awt.datatransfer.Transferable trans = new java.awt.datatransfer.StringSelection(text);
            sysClipboard.setContents(trans, null);
          }
        };
      }
      return m_clipboard;
    }
  }
}