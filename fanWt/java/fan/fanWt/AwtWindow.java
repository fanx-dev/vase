package fan.fanWt;

import javax.swing.JFrame;
import javax.swing.JPanel;

import fan.fan2d.*;

public class AwtWindow implements Window {

  View rootView;
  JFrame frame;
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
    frame = new JFrame();
    canvas = new AwtCanvas();
    frame.setContentPane(canvas);
    this.rootView = rootView;
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    ComponentUtils.bindEvent(rootView, frame);
  }

  @Override
  public void focus() {
    frame.requestFocus();
  }

  @Override
  public boolean hasFocus() {
    return frame.hasFocus();
  }

  @Override
  public Point pos() {
    return Point.make(frame.getX(), frame.getY());
  }

  @Override
  public void repaint() {
    this.repaint();
  }

  @Override
  public void repaint(Rect r) {
    frame.repaint((int)r.x, (int)r.y, (int)r.w, (int)r.h);
  }

  @Override
  public void repaintLater() {
    frame.repaint(1000);
  }

  @Override
  public void repaintLater(Rect r) {
    frame.repaint(1000, (int)r.x, (int)r.y, (int)r.w, (int)r.h);
  }

  @Override
  public void show() {
    frame.pack();
    frame.setVisible(true);
    try {
      Thread.sleep(Long.MAX_VALUE);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

  @Override
  public void show(Size s) {
    frame.setSize((int)s.w, (int)s.h);
    frame.setVisible(true);
    try {
      Thread.sleep(Long.MAX_VALUE);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

  @Override
  public Size size() {
    return Size.make(frame.getWidth(), frame.getHeight());
  }

}