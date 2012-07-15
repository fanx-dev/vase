package fan.fanWt;

import javax.swing.JFrame;
import javax.swing.JPanel;

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
  public void repaintLater() {
  	canvas.repaint(1000);
  }

  @Override
  public void repaintLater(Rect r) {
  	canvas.repaint(1000, (int)r.x, (int)r.y, (int)r.w, (int)r.h);
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
  	
  	if (s != null) {
  		frame.setSize((int)s.w, (int)s.h);
  	} else {
  		frame.pack();
  	}
    
    frame.setVisible(true);
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

}