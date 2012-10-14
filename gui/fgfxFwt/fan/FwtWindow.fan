//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** Canvas stub
**
@Js
class FwtCanvas : fwt::Canvas
{
  private FwtWindow win

  new make(FwtWindow win)
  {
    this.win = win
    doubleBuffered = true
  }
  override Void onPaint(gfx::Graphics gc)
  {
    Graphics g := FwtToolkitEnv.toGraphics(gc)
    win.view.onPaint(g)
  }

  internal Void bindEvent()
  {
    this.onMouseDown.add { postMotionEvent(it, MotionEvent.pressed) }
    this.onMouseMove.add { postMotionEvent(it, MotionEvent.moved) }
    this.onMouseUp.add { postMotionEvent(it, MotionEvent.released) }
    this.onMouseWheel.add { postMotionEvent(it, MotionEvent.other) }

    // I do not find the typed event in SWT
    this.onKeyDown.add { postKeyEvent(it, KeyEvent.pressed); postKeyEvent(it, KeyEvent.typed) }
    this.onKeyUp.add { postKeyEvent(it, KeyEvent.released) }

    this.onBlur.add { postDisplayEvent(it, DisplayEvent.lostFocus) }
    this.onFocus.add { postDisplayEvent(it, DisplayEvent.gainedFocus) }

    win.fwtWin.onOpen.add { postDisplayEvent(it, DisplayEvent.opened) }
    win.fwtWin.onClose.add { postDisplayEvent(it, DisplayEvent.closing) }
    win.fwtWin.onActive.add { postDisplayEvent(it, DisplayEvent.activated) }
    win.fwtWin.onInactive.add { postDisplayEvent(it, DisplayEvent.deactivated) }
    win.fwtWin.onDeiconified.add { postDisplayEvent(it, DisplayEvent.deiconified) }
    win.fwtWin.onIconified.add { postDisplayEvent(it, DisplayEvent.iconified) }
  }

  private Void postMotionEvent(fwt::Event e, Int id)
  {
    MotionEvent ce := MotionEvent(id)
    ce.x = e.pos?.x
    ce.y = e.pos?.y
    ce.button = e.button
    ce.count = e.count
    ce.delta = e.delta?.y
    ce.rawEvent = e
    win.view.onMotionEvent(ce)
  }

  private Void postKeyEvent(fwt::Event e, Int id)
  {
    KeyEvent ce := KeyEvent(id)
    ce.keyChar = e.keyChar
    //JS bug
    if (ce.keyChar == null)
    {
      ce.keyChar = e.key.primary->mask
    }
    ce.key = Key(e.key.toStr)
    win.view.onKeyEvent(ce)
  }

  private Void postDisplayEvent(fwt::Event e, Int id)
  {
    DisplayEvent ce := DisplayEvent(id)
    win.view.onDisplayEvent(ce)
  }
}

**
** Fwt Window
**
@Js
class FwtWindow : Window
{
  FwtCanvas canvas
  View view
  internal fwt::Window fwtWin

  new make(View view, fwt::Window? win := null)
  {
    this.view = view
    canvas = FwtCanvas(this)

    if (win != null)
    {
      fwtWin = win
    }
    else
    {
      fwtWin = fwt::Window
      {
        content = canvas
      }
    }

    canvas.bindEvent
  }

  override Void repaint(Rect? dirty := null)
  {
    canvas.repaint(gfx::Rect(dirty.x, dirty.y, dirty.w, dirty.h))
  }

  override Size size()
  {
    return Size.make(canvas.size.w, canvas.size.h)
  }
  override Point pos()
  {
    return Point(canvas.pos.x, canvas.pos.y)
  }

  override Void show(Size? size := null)
  {
    fwtWin.size = gfx::Size(size.w, size.h)
    fwtWin.open
  }

  override Bool hasFocus() { canvas.hasFocus }
  override Void focus() { canvas.focus }
}

**
** Toolkit
**
@Js
const class FwtToolkit : Toolkit
{
  override Window build(View view)
  {
    win := FwtWindow(view)
    return win
  }

  override Void callLater(Int delay, |->| f)
  {
    fwt::Desktop.callLater(Duration(delay*1000000), f)
  }
}