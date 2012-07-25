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
        view.onEvent(toCEvent(e, InputEvent.mouseClicked));
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
        view.onEvent(toCEvent(e, InputEvent.mouseDragged));
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
        ce.key(keyCodeToKey(e.getKeyCode()));
        view.onEvent(ce);
      }

      @Override
      public void keyReleased(KeyEvent e) {
        InputEvent ce = InputEvent.make(InputEvent.keyUp);
        ce.keyChar((long)e.getKeyChar());
        ce.key(keyCodeToKey(e.getKeyCode()));
        view.onEvent(ce);
      }

      @Override
      public void keyTyped(KeyEvent e) {
        InputEvent ce = InputEvent.make(InputEvent.keyTyped);
        ce.keyChar((long)e.getKeyChar());
        ce.key(keyCodeToKey(e.getKeyCode()));
        view.onEvent(ce);
      }
    });
  }

  static Key keyCodeToKey(int keyCode)
  {
    // TODO FIXIT: map rest of non-alpha keys
    switch (keyCode)
    {
      case KeyEvent.VK_BACK_SPACE :   return Key.backspace;
      case KeyEvent.VK_ENTER :  return Key.enter;
      case KeyEvent.VK_SPACE :  return Key.space;
      case KeyEvent.VK_LEFT :  return Key.left;
      case KeyEvent.VK_UP:  return Key.up;
      case KeyEvent.VK_RIGHT :  return Key.right;
      case KeyEvent.VK_DOWN :  return Key.down;
      case KeyEvent.VK_DELETE :  return Key.delete;
      case KeyEvent.VK_SEMICOLON : return Key.semicolon;
      case KeyEvent.VK_COMMA : return Key.comma;
      case KeyEvent.VK_PERIOD : return Key.period;
      case KeyEvent.VK_SLASH : return Key.slash;
      case KeyEvent.VK_DEAD_TILDE : return Key.backtick;
      case KeyEvent.VK_OPEN_BRACKET : return Key.openBracket;
      case KeyEvent.VK_BACK_SLASH : return Key.backSlash;
      case KeyEvent.VK_CLOSE_BRACKET : return Key.closeBracket;
      case KeyEvent.VK_QUOTE : return Key.quote;
      default:  return Key.fromMask(keyCode);
    }
  }
}