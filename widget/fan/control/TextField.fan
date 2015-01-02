//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** A place within a document view that represents
** where things can be inserted into the document model.
**
@Js
class Caret
{
  Bool visible := false
  Int offset := 0
}

**
** JTextField is a lightweight component that allows the editing of a single line of text.
**
@Js
class TextField : Widget, TextView
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

  override Font font := Font(dpToPixel(41))

  Caret caret := Caret()
  private Timer? timer

  new make()
  {
    //this.layoutParam.width = font.height * 10
    onFocusChanged.add |e| {
      focused := e.data
      if (focused)
      {
        startCaret
      }
      else
      {
        stopCaret
        caret.visible = false
        requestPaint
      }
    }
    this.padding = Insets(dpToPixel(20))
  }

  override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    return TextView.super.prefContentSize(hintsWidth, hintsHeight, result)
  }

  private Void startCaret()
  {
    if (timer != null && !timer.canceled) return

    //show caret
    caret.visible = true
    requestPaint

    //caret blink
    timer = Timer(500)|->|
    {
      if (this.hasFocus)
      {
        caret.visible = !caret.visible
        requestPaint
      }
    }
    timer.start
  }

  private Void stopCaret() { timer?.cancel }


  override Void keyPress(KeyEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (e.type == KeyEvent.pressed)
      {
        if (text.size > 0)
        {
          text = text[0..-2]
          requestPaint
        }
      }
      return
    }

    if (e.type != KeyEvent.typed) return

    if (e.keyChar < 32) return

    text += e.keyChar.toChar
    requestPaint
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