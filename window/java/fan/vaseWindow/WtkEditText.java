package fan.vaseWindow;

import fan.vaseGraphics.Color;
import fan.vaseGraphics.Font;
import fan.vaseGraphics.Point;
import fan.vaseGraphics.Size;
import fan.vaseWindow.TextInput;
import fan.vaseWindow.Window;

import javax.swing.text.JTextComponent;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import javax.swing.JPasswordField;
import java.awt.event.KeyAdapter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.text.Document;
import javax.swing.event.DocumentListener;
import javax.swing.event.DocumentEvent;
import javax.swing.text.BadLocationException;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;


class WtkEditText extends TextInput {
  JTextComponent textComp;

  WtkEditText(long inputType) {
    if (inputType == TextInput.inputTypePassword) {
      textComp = new JPasswordField();
    }
    else if (inputType == TextInput.inputTypeMultiLine) {
      textComp = new JTextArea();
    }
    else {
      textComp = new JTextField();
    }
    init(textComp);
  }

  private void init(JTextComponent textComp) {
    if (textComp instanceof JTextField) {
      ((JTextField)textComp).addActionListener(new ActionListener(){
        public void actionPerformed(ActionEvent ev){
          WtkEditText.super.keyAction(textComp.getText()); 
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
        WtkEditText.super.onKeyEvent(ce);
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

    // FocusAdapter focus = new FocusAdapter() {
    //     @Override
    //     public void focusLost(FocusEvent e) {
    //        System.out.println("lost: " + textComp.getText());
    //     }
    // };
    // textComp.addFocusListener(focus);

  }

  private void docChange(DocumentEvent e) {
    try {
      //Document doc = e.getDocument();
      //String txt = doc.getText(0, doc.getLength());
      String txt = this.textChange(textComp.getText());
      //textComp.setText(txt);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  public JTextComponent comp() {
    return textComp;
  }

  @Override
  public void setPos(long x, long y, long w, long h) {
    textComp.setSize((int)w, (int)h);
    textComp.setLocation((int)x, (int)y);
    //textComp.setBound((int)x, (int)y, (int)w, (int)h);
    textComp.validate(); 
    textComp.repaint();
  }
  @Override
  public void setStyle(Font font, Color textColor, Color backgroundColor) {
    textComp.setFont(WtkUtil.toFont(font));
    textComp.setBackground(WtkUtil.toAwtColor(backgroundColor));
    textComp.setForeground(WtkUtil.toAwtColor(textColor));
    //System.out.println("set Style");
  }
  @Override
  public void setText(String text) {
    textComp.setText(text);
  }
  @Override
  public void setType(long multiLine, boolean editable) {
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
    //System.out.println("close "+textComp);
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