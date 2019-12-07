package fan.vaseWindow;

import fan.vaseGraphics.Color;
import fan.vaseGraphics.Font;
import fan.vaseGraphics.Point;
import fan.vaseGraphics.Size;
import fan.vaseWindow.TextInput;
import fan.vaseWindow.TextInputPeer;
import fan.vaseWindow.Window;

import javax.swing.text.JTextComponent;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import java.awt.event.KeyAdapter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.text.Document;
import javax.swing.event.DocumentListener;
import javax.swing.event.DocumentEvent;
import javax.swing.text.BadLocationException;

class WtkEditText implements TextInputPeer {
  JTextComponent textComp;
  TextInput view;

  WtkEditText(TextInput textInput) {
    this.view = textInput;
    textComp = new JTextField();
    init(textComp);
  }

  private void init(JTextComponent textComp) {
    if (textComp instanceof JTextField) {
      ((JTextField)textComp).addActionListener(new ActionListener(){
        public void actionPerformed(ActionEvent ev){
          view.keyAction(textComp.getText()); 
        }
      });
    }

    textComp.addKeyListener(new KeyAdapter() {
      @Override
      public void keyPressed(java.awt.event.KeyEvent e) {
        sendKeyEvent(e, KeyEvent.pressed);
      }

      @Override
      public void keyReleased(java.awt.event.KeyEvent e) {
        sendKeyEvent(e, KeyEvent.released);
      }

      @Override
      public void keyTyped(java.awt.event.KeyEvent e) {
        sendKeyEvent(e, KeyEvent.typed);
      }

      private void sendKeyEvent(java.awt.event.KeyEvent e, long type) {
        KeyEvent ce = ComponentUtils.keyEventToFan(e, type);
        view.onKeyEvent(ce);
        if (ce.consumed()) e.consume();
      }
    });
  
    textComp.getDocument().addDocumentListener(new DocumentListener() {
      public void insertUpdate(DocumentEvent e) {
        docChange(e);
      }
      public void removeUpdate(DocumentEvent e) {
        docChange(e);
      }
      public void changedUpdate(DocumentEvent e) {
        docChange(e);
      }
    });
  }

  private void docChange(DocumentEvent e) {
    try {
      //Document doc = e.getDocument();
      //String txt = doc.getText(0, doc.getLength());
      String txt = view.textChange(textComp.getText());
      //textComp.setText(txt);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  public JTextComponent comp() {
    return textComp;
  }
/*
  //@Override
  public void update() {
    //setInputType(view.inputType());

    Point pos = view.getPos();
    Size size = view.getSize();
    textComp.setSize((int)size.w, (int)size.h);
    textComp.setLocation((int)pos.x, (int)pos.y);
    //textComp.setBound(pos.x, pos.y, size.w, size.h);
    if (onlyPos) {
      return;
    }

    textComp.setFont(WtkUtil.toFont(view.font()));
    textComp.setBackground(WtkUtil.toAwtColor(view.backgroundColor()));
    textComp.setForeground(WtkUtil.toAwtColor(view.textColor()));

    //TODO
    //this.setTextIsSelectable(view.selectable());
    //this.setSingleLine(view.singleLine());

    String text = view.text();
    textComp.setText(text);
    //super.setTextKeepState(t);
    //super.setSelection(text.length());

    textComp.requestFocus();
  }
*/
  @Override
  public void setPos(long x, long y, long w, long h) {
    textComp.setSize((int)w, (int)h);
    textComp.setLocation((int)x, (int)y);
    //textComp.setBound((int)x, (int)y, (int)w, (int)h);
  }
  @Override
  public void setStyle(Font font, Color textColor, Color backgroundColor) {
    textComp.setFont(WtkUtil.toFont(font));
    textComp.setBackground(WtkUtil.toAwtColor(backgroundColor));
    textComp.setForeground(WtkUtil.toAwtColor(textColor));
  }
  @Override
  public void setText(String text) {
    textComp.setText(text);
  }
  @Override
  public void setType(long multiLine, long inputType, boolean editable) {
    if (multiLine <= 1) {
      if (!(textComp instanceof JTextField)) {
        this.close();
        textComp = new JTextField();
        init(textComp);
      }
    }
    else {
      if (!(textComp instanceof JTextArea)) {
        this.close();
        textComp = new JTextArea();
        init(textComp);
      }
    }
    textComp.setEditable(editable);
  }
  @Override
  public void focus() {
    textComp.requestFocus();
  }

  @Override
  public void close() {
    java.awt.Container p = textComp.getParent();
    if (p != null) p.remove(textComp);
  }

  @Override
  public void select(long start, long end) {
    textComp.select((int)start, (int)end);
    textComp.setCaretPosition((int)start);
  }

  @Override
  public long caretPos() {
    return textComp.getCaretPosition();
  }
}