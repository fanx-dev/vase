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
  Int offset := 0
}

**
** EditText.
**
@Js
class EditText : Widget, TextInput
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
    getStyle.font
  }

  @Transient
  Caret caret := Caret()

  @Transient
  private Timer? timer

  @Transient
  override TextInputPeer? host

  new make(|This| f)
  {
    f(this)

    //this.layout.width = font.height * 10
    onFocusChanged.add |e| {
      focused := e.data
      if (focused)
      {
        this.getRootView.host?.textInput(this)
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
        }
        repaint
      }
    }
    this.padding = Insets(20)
    focusable = true
  }

  override Str textChange(Str text) {
    this.text = text
    return text;
  }

  override Void keyAction(Str text) {
    this.text = text;
  }
/*
  override Point getPos() { Point(x, y) }
  override Size getSize() { super.size }

  override Int inputType() { 1 }
  override Bool singleLine() { true }
  override Bool editable() { true }

  override Color textColor() { Color.black }
  override Color backgroundColor() { Color.white }
*/

  const Int inputType := 1
  override Int getInputType() { inputType }
  Bool editable := true

  private Void updateHost() {
    if (host == null) return
    multiLine := lines == null ? 1 : lines.size
    host.setType(multiLine, editable)
    
    p := Coord(0f, 0f)
    this.posOnWindow(p)
    host.setPos(p.x.toInt, p.y.toInt, width, height)
    //host.setStyle(font, Color.black, Color.white)
    host.setStyle(font, Color.black, Color(0xe0e0e0))
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
      if (this.hasFocus)
      {
        caret.visible = !caret.visible
        repaint
      }
    }
    timer.start
  }

  private Void stopCaret() { timer?.cancel }

  override Void onKeyEvent(KeyEvent e) {
  }

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