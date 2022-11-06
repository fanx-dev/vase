//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** A place within a document view that represents
** where things can be inserted into the document model.
**
@Js
virtual class Caret
{
  Bool visible := false
  
  ** offset of line
  Int offset := 0
}

**
** EditText.
**
@Js
class EditText : Widget
{
  Str text := ""
  {
    set
    {
      e := StateChangedEvent (&text, it, #text, this )
      onStateChanged.fire(e)
      &text = it
      caret.offset = &text.size
      if (it.containsChar('\n')) {
        lines = it.split('\n')
      }
      else {
        lines = null
      }
    }
  }
  
  internal Str[]? lines

  Str hint := ""
  Bool password() { inputType == TextInput.inputTypePassword }

  Font font() {
    getStyle.font(this)
  }

  @Transient
  Caret caret := Caret()

  @Transient
  private Timer? timer

  @Transient
  protected TextInput? host

  new make()
  {
    //this.layout.width = font.height * 10
    onFocusChanged.add |e| {
      focused := e.data
      if (focused)
      {
        host = this.getRootView.host?.textInput(inputType)
        host.onTextChange = |text->Str| {
            this.text = text
            return text;
        }
        host.onKeyAction = |text| {
            this.text = text
        }
        updateHost
        if (host == null) {
          startCaret
        }
      }
      else
      {
        stopCaret
        caret.visible = false
        if (host != null) {
          host.close
          host = null
        }
        repaint
      }
    }
    this.padding = Insets(20)
    focusable = true
  }

  const Int inputType := 1
  //override Int getInputType() { inputType }
  Bool editable := true

  private Void updateHost() {
    if (host == null) return
    multiLine := lines == null ? 1 : lines.size
    host.setType(multiLine, editable)
    
    p := this.posOnWindow
    host.setPos(p.x.toInt, p.y.toInt, width, height)

    WidgetStyle style = getStyle
    color := style.fontColor
    bgColor := style.background
    host.setStyle(font, color, bgColor)
    //host.setStyle(font, Color.black, Color(0xe0e0e0))
    host.setText(text)
    host.focus
  }

  protected override Void layoutChildren(Bool force) {
    super.layoutChildren(force)
    updateHost
  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    w := font.width(text)
    h := font.height
    if (lines != null) {
      h *= lines.size
    }
    return Size(w, h)
  }

  private Void startCaret()
  {
    if (timer != null && !timer.canceled) return

    //show caret
    caret.visible = true
    repaint

    //caret blink
    timer = Timer(500)|->|
    {
      if (this.focused)
      {
        caret.visible = !caret.visible
        repaint
      }
    }
    timer.start
  }

  private Void stopCaret() { timer?.cancel }


  override Void keyEvent(KeyEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (e.type == KeyEvent.pressed)
      {
        if (text.size > 0)
        {
          text = text[0..-2]
          repaint
        }
      }
      return
    }

    if (e.type != KeyEvent.typed) return

    if (e.keyChar < 32) return

    text += e.keyChar.toChar
    repaint
  }

  protected override Void gestureEvent(GestureEvent e)
  {
    if (e.type == GestureEvent.click)
    {
      focus
      e.consume
    }
  }
}