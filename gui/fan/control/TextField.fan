//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

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
** JTextField is a lightweight component that allows the editing of a single line of text.
**
@Js
class TextField : Widget, TextInput
{
  override Str text := ""
  {
    set
    {
      e := StateChangedEvent (&text, it, #text, this )
      onStateChanged.fire(e)
      &text = it
      caret.offset = &text.size
    }
  }

  Str hint := ""
  Bool password := false

  override Font font() {
    getStyle.font
  }

  @Transient
  Caret caret := Caret()

  @Transient
  private Timer? timer

  @Transient
  override TextInputPeer? host

  new make()
  {
    //this.layoutParam.width = font.height * 10
    onFocusChanged.add |e| {
      focused := e.data
      if (focused)
      {
        this.getRootView.host?.textInput(this)
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
  }

  override Str textChange(Str text) {
    this.text = text
    return text;
  }

  override Void keyAction(Str text) {
    this.text = text;
  }

  override Point getPos() { Point(x, y) }
  override Size getSize() { super.size }

  override Int inputType() { 1 }
  override Bool singleLine() { true }
  override Bool editable() { true }

  override Color textColor() { Color.black }
  override Color backgroundColor() { Color.white }

  protected override Void layoutChildren(Dimension result, Bool force) {
    super.layoutChildren(result, force)
    host?.update
  }

  protected override Dimension prefContentSize(Dimension result) {
    w := font.width(text)
    h := font.height
    return result.set(w, h)
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