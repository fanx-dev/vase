package fan.fgfxWtk;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.EventQueue;
import java.awt.event.*;
import java.awt.Dimension;

import fan.fgfxGraphics.*;

public class AwtView implements NativeView {

  View view;
  Window win;
  AwtCanvas canvas;

  class AwtCanvas extends JPanel {
    private static final long serialVersionUID = 1L;

    @Override
    public void paint(java.awt.Graphics g) {
      Graphics gc = new AwtGraphics((java.awt.Graphics2D)g);
      view.onPaint(gc);
    }
    /*
    @Override
    public void doLayout() {
      super.doLayout();
      view.onResize(canvas.getWidth(), canvas.getHeight());
    }*/
  }

  public AwtView(View rootView) {
    canvas = new AwtCanvas();
    this.view = rootView;
    ComponentUtils.bindEvent(view, canvas);

    //TODO fix size
    Size size = rootView.getPrefSize(600, 600);
    canvas.setPreferredSize(new Dimension((int)size.w, (int)size.h));
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

  @Override
  public Window win() {
    return win;
  }
}