package fan.fanvasWindow;

import java.awt.EventQueue;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.awt.event.WindowStateListener;

import javax.swing.JFrame;

import fan.fanvasGraphics.Size;

public class WtkWindow implements Window {

  JFrame frame;
  java.util.List<View> list;

  WtkWindow() {
    frame = new JFrame();
    list = new java.util.ArrayList<View>();
  }

  @Override
  public WtkWindow add(View view) {
    if (view instanceof fan.fanvasWindow.EditText) {
      return this;
    }
    WtkView awtView = new WtkView(view);
    awtView.win = this;
    view.host(awtView);
    frame.add(awtView.canvas);
    list.add(view);
    return this;
  }

  @Override
  public void remove(View view) {
    list.remove(view);
    frame.remove(((WtkView)view).canvas);
  }

  @Override
  public void show() {
    show(null);
  }

  @Override
  public void show(Size s) {
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    //frame.setContentPane(canvas);
    frame.addWindowStateListener(winStateListenner);
    frame.addWindowListener(winListener);

    if (s != null) {
      frame.setSize((int)s.w, (int)s.h);
    } else {
      frame.pack();
    }

    EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        ToolkitEnvPeer.init();
      }
    });

    frame.setVisible(true);

    try {
      Thread.sleep(Long.MAX_VALUE);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////

  private void postDisplayEvent(int id)
  {
    long fid = id;
    switch(id)
    {
    case WindowEvent.WINDOW_ACTIVATED:
      fid = DisplayEvent.activated;
      break;
    case WindowEvent.WINDOW_OPENED:
      fid = DisplayEvent.opened;
      break;
    }

    DisplayEvent e = DisplayEvent.make(fid);
    for (int i=0,n=list.size(); i<n; ++i)
    {
      View v = (View)list.get(i);
      v.onDisplayEvent(e);
    }
  }

  private WindowListener winListener = new WindowListener()
  {
    public void windowClosing(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowClosed(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowOpened(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowIconified(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowDeiconified(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowActivated(WindowEvent e) {
      postDisplayEvent(e.getID());
    }

    public void windowDeactivated(WindowEvent e) {
      postDisplayEvent(e.getID());
    }
  };

  private WindowStateListener winStateListenner = new WindowStateListener()
  {
    public void windowStateChanged(WindowEvent e)
    {
      postDisplayEvent(e.getID());
    }
  };

}