
package fan.vaseWindow;

import java.awt.Component;
import java.awt.event.*;

public class ComponentUtils {
  private static MotionEvent toCEvent(MouseEvent e, long type)
  {
    MotionEvent ce = MotionEvent.make(type);
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
        MotionEvent ce = MotionEvent.make(MotionEvent.wheel);
        ce.x((long)e.getX());
        ce.y((long)e.getY());
        ce.delta((long)e.getWheelRotation());
        view.onMotionEvent(ce);
      }
    });
    component.addMouseListener(new MouseListener() {

      @Override
      public void mouseClicked(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.clicked));
      }

      @Override
      public void mouseEntered(MouseEvent e) {
        //view.onMotionEvent(toCEvent(e, MotionEvent.mouseEnter));
      }

      @Override
      public void mouseExited(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.mouseOut));
      }

      @Override
      public void mousePressed(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.pressed));
      }

      @Override
      public void mouseReleased(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.released));
      }

    });

    component.addMouseMotionListener(new MouseMotionListener() {
      @Override
      public void mouseDragged(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.moved));
      }

      @Override
      public void mouseMoved(MouseEvent e) {
        view.onMotionEvent(toCEvent(e, MotionEvent.mouseMove));
      }
    });

    component.addKeyListener(new KeyListener() {
      @Override
      public void keyPressed(java.awt.event.KeyEvent e) {
        KeyEvent ce = keyEventToFan(e, KeyEvent.pressed);
        view.onKeyEvent(ce);
      }

      @Override
      public void keyReleased(java.awt.event.KeyEvent e) {
        KeyEvent ce = keyEventToFan(e, KeyEvent.released);
        view.onKeyEvent(ce);
      }

      @Override
      public void keyTyped(java.awt.event.KeyEvent e) {
        KeyEvent ce = keyEventToFan(e, KeyEvent.typed);
        view.onKeyEvent(ce);
      }
    });
  }

  static KeyEvent keyEventToFan(java.awt.event.KeyEvent e, long type)
  {
    KeyEvent ce = KeyEvent.make(type);
    ce.keyChar((long)e.getKeyChar());
    Key key = keyCodeToKey(e.getKeyCode());
    if ((e.getModifiers() & java.awt.event.KeyEvent.CTRL_MASK) != 0) {
      key = key.plus(Key.ctrl);
    }
    if ((e.getModifiers() & java.awt.event.KeyEvent.ALT_MASK) != 0) {
      key = key.plus(Key.alt);
    }
    if ((e.getModifiers() & java.awt.event.KeyEvent.SHIFT_MASK) != 0) {
      key = key.plus(Key.shift);
    }
    ce.key(key);
    return ce;
  }

  private static Key keyCodeToKey(int keyCode)
  {
    // TODO FIXIT: map rest of non-alpha keys
    switch (keyCode)
    {
      case java.awt.event.KeyEvent.VK_BACK_SPACE :   return Key.backspace;
      case java.awt.event.KeyEvent.VK_ENTER :  return Key.enter;
      case java.awt.event.KeyEvent.VK_SPACE :  return Key.space;
      case java.awt.event.KeyEvent.VK_LEFT :  return Key.left;
      case java.awt.event.KeyEvent.VK_UP:  return Key.up;
      case java.awt.event.KeyEvent.VK_RIGHT :  return Key.right;
      case java.awt.event.KeyEvent.VK_DOWN :  return Key.down;
      case java.awt.event.KeyEvent.VK_DELETE :  return Key.delete;
      case java.awt.event.KeyEvent.VK_SEMICOLON : return Key.semicolon;
      case java.awt.event.KeyEvent.VK_COMMA : return Key.comma;
      case java.awt.event.KeyEvent.VK_PERIOD : return Key.period;
      case java.awt.event.KeyEvent.VK_SLASH : return Key.slash;
      case java.awt.event.KeyEvent.VK_DEAD_TILDE : return Key.backtick;
      case java.awt.event.KeyEvent.VK_OPEN_BRACKET : return Key.openBracket;
      case java.awt.event.KeyEvent.VK_BACK_SLASH : return Key.backSlash;
      case java.awt.event.KeyEvent.VK_CLOSE_BRACKET : return Key.closeBracket;
      case java.awt.event.KeyEvent.VK_QUOTE : return Key.quote;
      default:  return Key.fromMask(keyCode);
    }
  }
}