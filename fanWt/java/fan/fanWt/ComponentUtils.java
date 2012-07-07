package fan.fanWt;

import java.awt.Component;
import java.awt.event.*;

public class ComponentUtils {
  private static InputEvent toCEvent(MouseEvent e, long id)
  {
  	InputEvent ce = InputEvent.make(id);
    ce.x((long)e.getX());
    ce.y((long)e.getY());
    ce.button((long)e.getButton());
    ce.count((long)e.getClickCount());
    return ce;
  }

  public static void bindEvent(final  View view,
      Component component) {
    component.addMouseWheelListener(new MouseWheelListener() {
      @Override
      public void mouseWheelMoved(MouseWheelEvent e) {
      	InputEvent ce = InputEvent.make(InputEvent.mouseWheel);
        ce.x((long)e.getX());
        ce.y((long)e.getY());
        ce.delta((long)e.getWheelRotation());
        view.onEvent(ce);
      }
    });
    component.addMouseListener(new MouseListener() {

      @Override
      public void mouseClicked(MouseEvent e) {
      }

      @Override
      public void mouseEntered(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseEnter));
      }

      @Override
      public void mouseExited(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseExit));
      }

      @Override
      public void mousePressed(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseDown));
      }

      @Override
      public void mouseReleased(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseUp));
      }

    });
    component.addMouseMotionListener(new MouseMotionListener() {
      @Override
      public void mouseDragged(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseMove));
      }

      @Override
      public void mouseMoved(MouseEvent e) {
      	view.onEvent(toCEvent(e, InputEvent.mouseMove));
      }
    });
    component.addKeyListener(new KeyListener() {
      @Override
      public void keyPressed(KeyEvent e) {
      	InputEvent ce = InputEvent.make(InputEvent.keyDown);
        ce.keyChar((long)e.getKeyChar());
        ce.key(Key.fromMask(e.getKeyCode()));
        view.onEvent(ce);
      }

      @Override
      public void keyReleased(KeyEvent e) {
      	InputEvent ce = InputEvent.make(InputEvent.keyUp);
        ce.keyChar((long)e.getKeyChar());
        ce.key(Key.fromMask(e.getKeyCode()));
        view.onEvent(ce);
      }

      @Override
      public void keyTyped(KeyEvent e) {
      	InputEvent ce = InputEvent.make(InputEvent.keyUp);
        ce.keyChar((long)e.getKeyChar());
        ce.key(Key.fromMask(e.getKeyCode()));
        view.onEvent(ce);
      }
    });
  }
}
