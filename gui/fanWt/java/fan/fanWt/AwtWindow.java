package fan.fanWt;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.EventQueue;
import java.awt.event.*;

import fan.fan2d.*;

public class AwtWindow implements Window {

  View rootView;

  AwtCanvas canvas;

  class AwtCanvas extends JPanel {
    private static final long serialVersionUID = 1L;

    @Override
    public void paint(java.awt.Graphics g) {
      Graphics gc = new AwtGraphics((java.awt.Graphics2D)g);
      rootView.onPaint(gc);
    }
  }

  AwtWindow(View rootView) {
    canvas = new AwtCanvas();
    this.rootView = rootView;
    ComponentUtils.bindEvent(rootView, canvas);
  }

  @Override
  public void focus() {
    canvas.requestFocus();
  }

  @Override
  public boolean hasFocus() {
    return canvas.hasFocus();
  }

  @Override
  public Point pos() {
    return Point.make(canvas.getX(), canvas.getY());
  }

  @Override
  public void repaint() {
    canvas.repaint();
  }

  @Override
  public void repaint(Rect r) {
    canvas.repaint((int)r.x, (int)r.y, (int)r.w, (int)r.h);
  }

  @Override
  public void show() {
    show(null);
  }

  @Override
  public void show(Size s) {
    JFrame frame = new JFrame();
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setContentPane(canvas);
    frame.addWindowStateListener(winStateListenner);
    frame.addWindowListener(winListener);

    if (s != null) {
      frame.setSize((int)s.w, (int)s.h);
    } else {
      frame.pack();
    }

    frame.setVisible(true);
    EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        ToolkitEnvPeer.init();
      }
    });
    try {
      Thread.sleep(Long.MAX_VALUE);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

  @Override
  public Size size() {
    return Size.make(canvas.getWidth(), canvas.getHeight());
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
    this.rootView.onDisplayEvent(e);
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