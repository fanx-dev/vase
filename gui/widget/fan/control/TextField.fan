//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** A place within a document view that represents
** where things can be inserted into the document model.
**
@Js
class Caret
{
  Bool visible := false
  Int x := 0
  Int y := 0
  Int h := 20
}

**
** JTextField is a lightweight component that allows the editing of a single line of text.
**
@Js
class TextField : Widget
{
  virtual Str text := ""
  {
    set
    {
      e := StateChangedEvent (&text, it, #text, this )
      onStateChanged.fire(e)
      &text = it
      caret.x = &text.size
    }
  }

  Caret caret := Caret()
  private Timer? timer

  new make()
  {
    size = Size(100, 20)
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

  override Void focusChanged(Bool focused)
  {
    if (focused)
    {
      startCaret
    }
    else
    {
      stopCaret
      caret.visible = false
      repaint
    }
  }

  override Void keyPress(KeyEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (e.id == KeyEvent.pressed)
      {
        if (text.size > 0)
        {
          text = text[0..-2]
          repaint
        }
      }
      return
    }

    if (e.id != KeyEvent.typed) return

    if (e.keyChar < 32) return

    text += e.keyChar.toChar
    repaint
  }

  override Void touch(MotionEvent e)
  {
    if (this.bounds.contains(e.x, e.y))
    {
      if (e.id == MotionEvent.pressed)
      {
        focus
      }
    }
  }
}