package fan.fgfxWtk;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.EventQueue;
import java.awt.event.*;

import fan.fgfx2d.*;

public class AwtView implements NativeView {

  View view;

  AwtCanvas canvas;

  class AwtCanvas extends JPanel {
    private static final long serialVersionUID = 1L;

    @Override
    public void paint(java.awt.Graphics g) {
      Graphics gc = new AwtGraphics((java.awt.Graphics2D)g);
      view.onPaint(gc);
    }
  }

  public AwtView(View rootView) {
    canvas = new AwtCanvas();
    this.view = rootView;
    ComponentUtils.bindEvent(view, canvas);
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
  public Size size() {
    return Size.make(canvas.getWidth(), canvas.getHeight());
  }
}