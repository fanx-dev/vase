//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class Caret
{
  Bool visible := false
  Int x := 0
  Int y := 0
  Int h := 20
}

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
  Timer? timer

  new make()
  {
    size = Size(100, 20)
  }

  private Void startCaret()
  {
    if (timer != null && !timer.canceled) return

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

  override Void keyPress(InputEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (e.id == InputEvent.keyDown)
      {
        if (text.size > 0)
        {
          text = text[0..-2]
          repaint
        }
      }
      return
    }

    if (e.id != InputEvent.keyTyped) return

    if (e.keyChar < 32) return

    text += e.keyChar.toChar
    repaint
  }

  override Void touch(InputEvent e)
  {
    if (this.bounds.contains(e.x, e.y))
    {
      if (e.type == InputEventType.press)
      {
        focus
      }
    }
  }
}