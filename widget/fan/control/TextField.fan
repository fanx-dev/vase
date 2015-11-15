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
class TextField : Widget, TextView, EditText
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

  override Font font := Font(dpToPixel(41f))

  Caret caret := Caret()
  private Timer? timer

  override NativeView? host

  new make()
  {
    //this.layoutParam.width = font.height * 10
    onFocusChanged.add |e| {
      focused := e.data
      if (focused)
      {
        this.getRootView.host.win.add(this)
        if (host == null) {
          startCaret
        } else {
          host?.focus
          resetNativeView
        }
      }
      else
      {
        stopCaret
        caret.visible = false
        if (host != null) {
          text = (host as NativeEditText).text
          this.getRootView.host.win.remove(this)
        }
        requestPaint
      }
    }
    this.padding = Insets(dpToPixel(20f))
  }

  override Void willTextChange(Str text) {
  }

  override Void didTextChange(Str text) {
    this.text = text
  }

  protected Void resetNativeView() {
    if (host == null) return
    NativeEditText edit := host

    edit.text = text
    Coord pos := Coord(x, y)
    rc := posOnWindow(pos)
    if (!rc) return
    edit.setBound(pos.x, pos.y, width, height)
  }

  protected override This doLayout(Dimension result) {
    rc := super.doLayout(result)
    resetNativeView
    return rc
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