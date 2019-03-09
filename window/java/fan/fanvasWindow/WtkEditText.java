package fan.fanvasWindow;

import fan.fanvasGraphics.Color;
import fan.fanvasGraphics.Font;
import fan.fanvasGraphics.Point;
import fan.fanvasGraphics.Size;
import fan.fanvasWindow.TextInput;
import fan.fanvasWindow.TextInputPeer;
import fan.fanvasWindow.Window;

import javax.swing.text.JTextComponent;
import javax.swing.JTextField;
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

    if (textComp instanceof JTextField) {
      ((JTextField)textComp).addActionListener(new ActionListener(){
        public void actionPerformed(ActionEvent ev){
          view.keyAction(textComp.getText()); 
        }
      });
    }

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

  @Override
  public void update() {
    //setInputType(view.inputType());

    textComp.setFont(WtkUtil.toFont(view.font()));

    textComp.setBackground(WtkUtil.toAwtColor(view.backgroundColor()));
    textComp.setForeground(WtkUtil.toAwtColor(view.textColor()));

    Point pos = view.getPos();
    Size size = view.getSize();
    textComp.setSize((int)size.w, (int)size.h);
    textComp.setLocation((int)pos.x, (int)pos.y);
    //textComp.setBound(pos.x, pos.y, size.w, size.h);

    //TODO
    //this.setTextIsSelectable(view.selectable());
    //this.setSingleLine(view.singleLine());

    String text = view.text();
    textComp.setText(text);
    //super.setTextKeepState(t);
    //super.setSelection(text.length());

    textComp.requestFocus();
  }

  @Override
  public void close() {
    java.awt.Container p = textComp.getParent();
    if (p != null) p.remove(textComp);
  }
}