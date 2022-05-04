//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.vaseWindow;

import java.awt.EventQueue;
import java.util.Timer;
import java.util.TimerTask;

import fan.concurrent.Actor;
import fan.sys.Func;


public class ToolkitPeer
{
  public static Toolkit instance = null;
  public static Toolkit instance() { return instance; }

  public static ToolkitPeer make(Toolkit self)
  {
    ToolkitPeer peer = new ToolkitPeer();
    return peer;
  }

  public static Toolkit cur()
  {
    if (instance == null) {
      Actor.locals().set("vaseGraphics.env", WtkGfxEnv.instance);
      ToolkitPeer.instance = AwtToolkit.instance;
      AwtToolkit.instance.uiThread = Thread.currentThread().getId();
    }
    return instance;
  }

  public static void initMainThread() {
    EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        ToolkitPeer.cur();
        Toolkit.tryInitAsyncRunner();
      }
    });
  }

  static class AwtToolkit extends Toolkit
  {
    static AwtToolkit instance = new AwtToolkit();
    private WtkWindow curWindow = null;
    private long uiThread = -1;

    Timer timer = new Timer(true);
    public WtkWindow window(View view, fan.std.Map options)
    {
      if (uiThread != Thread.currentThread().getId() && !EventQueue.isDispatchThread()) {
        throw new RuntimeException("must call in ui thread");
      }

      if (view != null) {
        curWindow = new WtkWindow(view);
        curWindow.show(null, options);
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


    public double density() { return 0.4; }


    @Override
    public fan.vaseGraphics.GfxEnv gfxEnv() {
      return WtkGfxEnv.instance;
    }

    @Override
    public boolean openUri(fan.std.Uri uri) { return openUri(uri, null); }
    @Override
    public boolean openUri(fan.std.Uri auri, fan.std.Map options) {
      try {
        java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
        if (desktop.isDesktopSupported()
            && desktop.isSupported(java.awt.Desktop.Action.BROWSE)) {
          java.net.URI uri = new java.net.URI(auri.toStr());
          desktop.browse(uri);
          return true;
        }
      } catch (Exception ex) {
        System.out.println(ex);
      }
      return false;
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