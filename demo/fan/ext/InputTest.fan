using vaseGui
using vaseWindow

@Js
class InputTest : BasePage
{
  protected TextInput? host
  private Label? label

  protected Void initHost() {
    host = frame.getRootView.host?.textInput(1)
    host.onTextChange = |text->Str| {
        echo(text)
        return text;
    }
    host.onKeyPress = |KeyEvent e| {
      if (e.type == KeyEvent.typed) {
        label.text += e.keyChar.toChar
        Toolkit.cur.callLater(0) |->| {
          host.setText("")
        }
      }
    }
    host.setPos(10, 150, 40, 30)

    //host.setStyle(font, color, bgColor)
    //host.setStyle(font, Color.black, Color(0xe0e0e0))
    //host.setText(text)
    host.focus
  }

  protected override Widget view() {
    label = Label {
      onClick() {
        if (host != null) {
            host.close
            host = null
        }
        else {
          initHost
        }
      }
    }
    return label
  }
}